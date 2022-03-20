import 'package:fpdart/fpdart.dart';
import 'package:helios_q1/src/features/paginated_list/data/data_sources/paginated_list_local_data_source.dart';
import 'package:helios_q1/src/features/paginated_list/data/data_sources/paginated_list_remote_data_source.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/user_model.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/user.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/paginated_list_repository.dart';

class PaginatedListRepositoryImpl implements PaginatedListRepository {
  final PaginatedListRemoteDataSource remoteDataSource;
  final PaginatedListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PaginatedListRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  List<UserModel> resultsPage = <UserModel>[];

  @override
  Future<Either<Failure, List<User>>> fetchNextResultsPage(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNextResultsPage =
            await remoteDataSource.fetchNextResultsPage(page);
        resultsPage.addAll(remoteNextResultsPage);
        localDataSource.cacheNextResultsPage(resultsPage);
        return Right(remoteNextResultsPage);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localLastResultsPage = await localDataSource.getLastResultsPage();
        return Right(localLastResultsPage);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
