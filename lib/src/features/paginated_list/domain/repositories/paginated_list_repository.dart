import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class PaginatedListRepository {
  Future<Either<Failure, List<User>>> fetchNextResultsPage(int page);
}
