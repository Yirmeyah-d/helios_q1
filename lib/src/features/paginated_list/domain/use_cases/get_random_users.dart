import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/user.dart';
import '../repositories/paginated_list_repository.dart';

class GetRandomUsers implements UseCase<List<User>, NoParams> {
  final PaginatedListRepository repository;

  GetRandomUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await repository.getRandomUsers();
  }
}
