import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:helios_q1/src/core/error/exceptions.dart';
import 'package:helios_q1/src/features/paginated_list/data/data_sources/paginated_list_local_data_source.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/dob_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/location_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/name_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/picture_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/street_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'paginated_list_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late PaginatedListLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = PaginatedListLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastResultsPage', () {
    // final jsonListString =
    //     jsonDecode(fixture("results_page_cached.json"));
    // final tUserModel = (jsonListString)
    //     .map((resultsPage) => UserModel.fromJson(resultsPage))
    //     .toList();

    // test(
    //   'should return ResultsPage from SharedPreferences when they are in the cache',
    //   () async {
    //     // arrange
    //     when(mockSharedPreferences.getStringList(any)).thenReturn(jsonListString as List<String>);
    //     // act
    //     final result = await dataSource.getLastResultsPage();
    //     // assert
    //     expect(result, equals(tUserModel));
    //   },
    // );

    test(
      'should throw a CacheException when there is not a cached value',
      () async {
        // arrange
        when(mockSharedPreferences.getStringList(any)).thenReturn(null);
        // act
        final call = dataSource.getLastResultsPage;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheNextResultsPage', () {
    final tUserModels = [
      const UserModel(
        name: NameModel(firstName: "Thomas", lastName: "Jefferson"),
        dob: DobModel(age: 46),
        email: "thomas.jeff@gmail.com",
        phoneNumber: "20302030203",
        profilePicture: PictureModel(urlPhotoMediumSize: "https:photo.png"),
        location: LocationModel(
          city: "Washington",
          street: StreetModel(number: "23", name: "Burger st"),
          postCode: "23832",
        ),
      ),
      const UserModel(
        name: NameModel(firstName: "Stephen", lastName: "Hawkins"),
        dob: DobModel(age: 57),
        email: "steph.hawk@gmail.com",
        phoneNumber: "20302044277",
        profilePicture: PictureModel(urlPhotoMediumSize: "https:photo.jpg"),
        location: LocationModel(
          city: "New York",
          street: StreetModel(number: "57", name: "Lincoln st"),
          postCode: "74954",
        ),
      ),
    ];
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // arrange
        when(mockSharedPreferences.setStringList(any, any))
            .thenAnswer((_) async => true);
        // act
        dataSource.cacheNextResultsPage(tUserModels);
        // assert
        final expectedJsonStringList = tUserModels
            .map((resultsPage) => jsonEncode(resultsPage.toJson()))
            .toList();
        verify(mockSharedPreferences.setStringList(
            CACHED_RESULTS_PAGE, expectedJsonStringList));
      },
    );
  });
}
