part of 'paginated_list_bloc.dart';

abstract class PaginatedListEvent extends Equatable {
  const PaginatedListEvent();
}

class GetRandomUsersEvent extends PaginatedListEvent {
  const GetRandomUsersEvent();

  @override
  List<Object> get props => [];
}

class GetCountryListEvent extends PaginatedListEvent {
  @override
  List<Object?> get props => [];
}
