import 'dart:convert';
import 'package:helios_q1/src/features/paginated_list/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';

abstract class PaginatedListLocalDataSource {
  /// Gets the cached list of [UserModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<UserModel>> getLastRandomUsers();

  /// Add in the cache the list of  [UserModel]
  ///
  Future<void> cacheRandomUsers(List<UserModel> randomUsersToCache);
}

const CACHED_RANDOM_USERS = 'CACHED_RANDOM_USERS';

class PaginatedListLocalDataSourceImpl implements PaginatedListLocalDataSource {
  final SharedPreferences sharedPreferences;

  PaginatedListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<UserModel>> getLastRandomUsers() {
    final jsonRandomUsers =
        sharedPreferences.getStringList(CACHED_RANDOM_USERS);
    if (jsonRandomUsers != null) {
      return Future.value(jsonRandomUsers
          .map((randomUser) => UserModel.fromJson(jsonDecode(randomUser)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheRandomUsers(List<UserModel> randomUsersToCache) {
    List<String> randomUsersEncoded = randomUsersToCache
        .map((randomUser) => jsonEncode(randomUser.toJson()))
        .toList();

    return sharedPreferences.setStringList(
      CACHED_RANDOM_USERS,
      randomUsersEncoded,
    );
  }
}
