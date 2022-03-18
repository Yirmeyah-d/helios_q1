part of 'paginated_list_bloc.dart';

abstract class PaginatedListState extends Equatable {
  const PaginatedListState();
}

class PaginatedListInitial extends PaginatedListState {
  @override
  List<Object> get props => [];
}

class PaginatedListLoading extends PaginatedListState {
  @override
  List<Object> get props => [];
}

class PaginatedListLoaded extends PaginatedListState {
  final List<User> randomUsers;

  const PaginatedListLoaded({required this.randomUsers});

  @override
  List<Object> get props => [randomUsers];
}

class PaginatedListError extends PaginatedListState {
  final String message;
  const PaginatedListError({required this.message});

  @override
  List<Object> get props => [message];
}
