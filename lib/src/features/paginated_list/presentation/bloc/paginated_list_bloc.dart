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
}
