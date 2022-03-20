import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/user.dart';
import '../repositories/paginated_list_repository.dart';

class FetchNextResultsPage implements UseCase<List<User>, Params> {
  final PaginatedListRepository repository;

  FetchNextResultsPage(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(Params params) async {
    return await repository.fetchNextResultsPage(params.page);
  }
}

class Params extends Equatable {
  final int page;

  const Params({required this.page});

  @override
  List<Object> get props => [page];
}
