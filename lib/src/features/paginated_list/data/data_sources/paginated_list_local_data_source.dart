import 'dart:convert';
import 'package:helios_q1/src/features/paginated_list/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';

abstract class PaginatedListLocalDataSource {
  /// Gets the cached list of [UserModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<UserModel>> getLastResultsPage();

  /// Add in the cache the list of  [UserModel]
  ///
  Future<void> cacheNextResultsPage(List<UserModel> resultsPageToCache);
}

const CACHED_RESULTS_PAGE = 'CACHED_RESULTS_PAGE';

class PaginatedListLocalDataSourceImpl implements PaginatedListLocalDataSource {
  final SharedPreferences sharedPreferences;

  PaginatedListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<UserModel>> getLastResultsPage() {
    final jsonResultsPage =
        sharedPreferences.getStringList(CACHED_RESULTS_PAGE);
    if (jsonResultsPage != null) {
      return Future.value(jsonResultsPage
          .map((resultsPage) => UserModel.fromJson(jsonDecode(resultsPage)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNextResultsPage(List<UserModel> resultsPageToCache) {
    List<String> resultsPageEncoded = resultsPageToCache
        .map((resultsPage) => jsonEncode(resultsPage.toJson()))
        .toList();

    return sharedPreferences.setStringList(
      CACHED_RESULTS_PAGE,
      resultsPageEncoded,
    );
  }
}
