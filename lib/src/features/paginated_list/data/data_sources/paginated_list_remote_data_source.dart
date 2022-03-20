import 'package:dio/dio.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/user_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class PaginatedListRemoteDataSource {
  /// Calls the https://randomuser.me/api/?page=1&results=20&seed=abc endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<UserModel>> fetchNextResultsPage(int page);
}

class PaginatedListRemoteDataSourceImpl
    implements PaginatedListRemoteDataSource {
  final Dio dio;

  PaginatedListRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UserModel>> fetchNextResultsPage(int page) async =>
      _fetchNextResultsPageFromUrl(
          'https://randomuser.me/api/?page=$page&results=20&seed=abc');

  Future<List<UserModel>> _fetchNextResultsPageFromUrl(String url) async {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      return (response.data["results"] as List)
          .map((nextResultsPage) => UserModel.fromJson(nextResultsPage))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
