import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:helios_q1/src/core/utils/failure_api.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/user.dart';
import 'package:helios_q1/src/features/paginated_list/domain/use_cases/get_random_users.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
part 'paginated_list_state.dart';
part 'paginated_list_event.dart';

class PaginatedListBloc extends Bloc<PaginatedListEvent, PaginatedListState> {
  final GetRandomUsers getRandomUsers;

  PaginatedListBloc({
    required this.getRandomUsers,
  }) : super(PaginatedListInitial()) {
    on<GetRandomUsersEvent>(_onGetRandomUsers);
  }

  void _eitherLoadedAfterGetRandomUsersOrErrorState(
    Either<Failure, List<User>> failureOrRandomUsers,
    Emitter<PaginatedListState> emit,
  ) {
    failureOrRandomUsers.fold(
      (failure) => emit(
        PaginatedListError(
          message: failure.mapFailureToMessage,
        ),
      ),
      (randomUsers) => emit(
        PaginatedListLoaded(
          randomUsers: randomUsers,
        ),
      ),
    );
  }

  Future<void> _onGetRandomUsers(
    GetRandomUsersEvent event,
    Emitter<PaginatedListState> emit,
  ) async {
    emit(PaginatedListLoading());
    final failureOrRandomUsers = await getRandomUsers(NoParams());
    _eitherLoadedAfterGetRandomUsersOrErrorState(
      failureOrRandomUsers,
      emit,
    );
  }
}
