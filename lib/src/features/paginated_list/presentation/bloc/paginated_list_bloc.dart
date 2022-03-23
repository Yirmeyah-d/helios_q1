import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:helios_q1/src/core/utils/failure_api.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/user.dart';
import 'package:helios_q1/src/features/paginated_list/domain/use_cases/fetch_next_result_page.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
part 'paginated_list_state.dart';
part 'paginated_list_event.dart';

class PaginatedListBloc extends Bloc<PaginatedListEvent, PaginatedListState> {
  final FetchNextResultsPage fetchNextResultsPage;
  final NetworkInfo networkInfo;

  int page = 1;
  List<User> resultsPage = <User>[];

  PaginatedListBloc({
    required this.networkInfo,
    required this.fetchNextResultsPage,
  }) : super(PaginatedListInitial()) {
    on<FetchNextResultsPageEvent>(_onFetchNextResultsPageEvent);
    on<SearchResultsEvent>(_onSearchResultsEvent);
    on<RefreshResultsEvent>(_onRefreshResultsEvent);
  }

  Future<void> _eitherLoadedStateAfterFetchNextResultsPageOrErrorState(
    Either<Failure, List<User>> failureOrNextResultsPage,
    Emitter<PaginatedListState> emit,
  ) async {
    await failureOrNextResultsPage.fold(
      (failure) async => emit(
        PaginatedListError(
          message: failure.mapFailureToMessage,
        ),
      ),
      (nextResultsPage) async {
        if (await networkInfo.isConnected) {
          resultsPage.addAll(nextResultsPage);
          page++;
        } else {
          resultsPage = nextResultsPage;
        }
        emit(
          PaginatedListLoaded(
            nextResultsPage: resultsPage,
            page: page,
          ),
        );
      },
    );
  }

  Future<void> _onFetchNextResultsPageEvent(
    FetchNextResultsPageEvent event,
    Emitter<PaginatedListState> emit,
  ) async {
    emit(PaginatedListLoading());
    final failureOrNextResultsPage =
        await fetchNextResultsPage(Params(page: page));
    await _eitherLoadedStateAfterFetchNextResultsPageOrErrorState(
      failureOrNextResultsPage,
      emit,
    );
  }

  Future<void> _onSearchResultsEvent(
    SearchResultsEvent event,
    Emitter<PaginatedListState> emit,
  ) async {
    emit(PaginatedListLoading());
    final searchResults = resultsPage.where((results) =>
        ("${results.name.firstName} ${results.name.lastName}")
            .startsWith(event.query));
    emit(PaginatedListLoaded(
        nextResultsPage: searchResults.toList(), page: page));
  }

  Future<void> _onRefreshResultsEvent(
    RefreshResultsEvent event,
    Emitter<PaginatedListState> emit,
  ) async {
    emit(PaginatedListLoading());
    emit(PaginatedListLoaded(nextResultsPage: resultsPage, page: page));
  }
}
