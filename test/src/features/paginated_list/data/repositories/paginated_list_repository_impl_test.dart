import 'package:fpdart/fpdart.dart';
import 'package:helios_q1/src/core/error/exceptions.dart';
import 'package:helios_q1/src/core/error/failures.dart';
import 'package:helios_q1/src/core/network/network_info.dart';
import 'package:helios_q1/src/features/paginated_list/data/data_sources/paginated_list_local_data_source.dart';
import 'package:helios_q1/src/features/paginated_list/data/data_sources/paginated_list_remote_data_source.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/dob_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/location_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/name_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/picture_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/street_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/user_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/repositories/paginated_list_repository_impl.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/user.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'paginated_list_repository_impl_test.mocks.dart';

@GenerateMocks(
    [PaginatedListRemoteDataSource, PaginatedListLocalDataSource, NetworkInfo])
void main() {
  MockPaginatedListRemoteDataSource mockRemoteDataSource =
      MockPaginatedListRemoteDataSource();
  MockPaginatedListLocalDataSource mockLocalDataSource =
      MockPaginatedListLocalDataSource();
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  PaginatedListRepositoryImpl repositoryImpl = PaginatedListRepositoryImpl(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockLocalDataSource,
    networkInfo: mockNetworkInfo,
  );

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('fetchNextResultsPage', () {
    const tPage = 1;
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
    final List<User> tUsers = tUserModels;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.fetchNextResultsPage(tPage))
            .thenAnswer((_) async => tUserModels);
        // act
        await repositoryImpl.fetchNextResultsPage(tPage);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.fetchNextResultsPage(any))
              .thenThrow(ServerException());
          // act
          final result = await repositoryImpl.fetchNextResultsPage(tPage);
          // assert
          verify(mockRemoteDataSource.fetchNextResultsPage(tPage));
          expect(result, equals(Left(ServerFailure())));
        },
      );

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.fetchNextResultsPage(any))
              .thenAnswer((_) async => tUserModels);
          // act
          final result = await repositoryImpl.fetchNextResultsPage(tPage);
          // assert
          verify(mockRemoteDataSource.fetchNextResultsPage(tPage));
          expect(result, equals(Right(tUsers)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.fetchNextResultsPage(any))
              .thenAnswer((_) async => tUserModels);
          // act
          await repositoryImpl.fetchNextResultsPage(tPage);
          // assert
          verify(mockLocalDataSource.cacheNextResultsPage(tUserModels));
          verify(mockRemoteDataSource.fetchNextResultsPage(tPage));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastResultsPage())
              .thenAnswer((_) async => tUserModels);
          // act
          final result = await repositoryImpl.fetchNextResultsPage(tPage);
          // assert
          verify(mockLocalDataSource.getLastResultsPage());
          expect(result, equals(Right(tUsers)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastResultsPage())
              .thenThrow(CacheException());
          // act
          final result = await repositoryImpl.fetchNextResultsPage(tPage);
          // assert
          verify(mockLocalDataSource.getLastResultsPage());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
