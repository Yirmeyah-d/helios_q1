part of 'paginated_list_bloc.dart';

abstract class PaginatedListEvent extends Equatable {
  const PaginatedListEvent();
}

class FetchNextResultsPageEvent extends PaginatedListEvent {
  const FetchNextResultsPageEvent();

  @override
  List<Object> get props => [];
}
