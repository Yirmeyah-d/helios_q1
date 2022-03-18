import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/user_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class PaginatedListRemoteDataSource {
  /// Calls the https://randomuser.me/api/?results=500 endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<UserModel>> getRandomUsers();
}

class PaginatedListRemoteDataSourceImpl
    implements PaginatedListRemoteDataSource {
  final Dio dio;

  PaginatedListRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UserModel>> getRandomUsers() async =>
      _getRandomUsersFromUrl('https://randomuser.me/api/?results=500');

  Future<List<UserModel>> _getRandomUsersFromUrl(String url) async {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      return (jsonDecode(response.data) as List)
          .map((randomUser) => UserModel.fromJson(randomUser))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
