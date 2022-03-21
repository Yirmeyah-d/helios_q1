part of 'paginated_list_bloc.dart';

abstract class PaginatedListEvent extends Equatable {
  const PaginatedListEvent();
}

class FetchNextResultsPageEvent extends PaginatedListEvent {
  const FetchNextResultsPageEvent();

  @override
  List<Object> get props => [];
}

class SearchResultsEvent extends PaginatedListEvent {
  final String query;
  const SearchResultsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class RefreshResultsEvent extends PaginatedListEvent {
  const RefreshResultsEvent();

  @override
  List<Object> get props => [];
}
