import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:helios_q1/src/core/error/failures.dart';
import 'package:helios_q1/src/core/network/network_info.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/dob.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/location.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/name.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/picture.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/street.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/user.dart';
import 'package:helios_q1/src/features/paginated_list/domain/use_cases/fetch_next_result_page.dart';
import 'package:helios_q1/src/features/paginated_list/presentation/bloc/paginated_list_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helios_q1/src/core/utils/failure_api.dart';
import 'paginated_list_bloc_test.mocks.dart';

@GenerateMocks([
  FetchNextResultsPage,
  NetworkInfo,
])
void main() {
  late PaginatedListBloc paginatedListBloc;
  late MockFetchNextResultsPage mockFetchNextResultsPage;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockFetchNextResultsPage = MockFetchNextResultsPage();
    mockNetworkInfo = MockNetworkInfo();
    paginatedListBloc = PaginatedListBloc(
      fetchNextResultsPage: mockFetchNextResultsPage,
      networkInfo: mockNetworkInfo,
    );
  });

  test('initialState should be PaginatedListInitial', () {
    //assert
    expect(paginatedListBloc.state, equals(PaginatedListInitial()));
  });

  test('page should be equal to 1 at the beginning', () {
    //assert
    expect(paginatedListBloc.page, equals(1));
  });

  test('resultsPage should be an empty list at the beginning', () {
    //assert
    expect(paginatedListBloc.resultsPage, equals([]));
  });

  group('FetchNextResultsPageEvent', () {
    const tPage = 1;
    const tUsers = [
      User(
        name: Name(firstName: "Thomas", lastName: "Jefferson"),
        dob: Dob(age: 46),
        email: "thomas.jeff@gmail.com",
        phoneNumber: "20302030203",
        profilePicture: Picture(urlPhotoMediumSize: "https:photo.png"),
        location: Location(
          city: "Washington",
          street: Street(number: "23", name: "Burger st"),
          postCode: "23832",
        ),
      ),
      User(
        name: Name(firstName: "Stephen", lastName: "Hawkins"),
        dob: Dob(age: 57),
        email: "steph.hawk@gmail.com",
        phoneNumber: "20302044277",
        profilePicture: Picture(urlPhotoMediumSize: "https:photo.jpg"),
        location: Location(
          city: "New York",
          street: Street(number: "57", name: "Lincoln st"),
          postCode: "74954",
        ),
      ),
    ];
    void setUpMockFetchNextResultsPageSuccess() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockFetchNextResultsPage(any))
          .thenAnswer((_) async => const Right(tUsers));
    }

    void setUpMockFetchNextResultsPageFailure(Failure failure) {
      when(mockFetchNextResultsPage(any))
          .thenAnswer((_) async => Left(failure));
    }

    blocTest<PaginatedListBloc, PaginatedListState>(
      'should get data from the fetch next results page use case',
      build: () {
        setUpMockFetchNextResultsPageSuccess();
        return paginatedListBloc;
      },
      act: (bloc) async {
        bloc.add(const FetchNextResultsPageEvent());
        await untilCalled(mockFetchNextResultsPage(any));
      },
      verify: (_) {
        verify(mockFetchNextResultsPage(const Params(page: tPage)));
      },
    );

    blocTest<PaginatedListBloc, PaginatedListState>(
      'emit [PaginatedListLoading,PaginatedListLoaded] when data is gotten successfully',
      build: () {
        setUpMockFetchNextResultsPageSuccess();
        return paginatedListBloc;
      },
      act: (bloc) => bloc.add(const FetchNextResultsPageEvent()),
      expect: () => [
        PaginatedListLoading(),
        const PaginatedListLoaded(nextResultsPage: tUsers, page: 2),
      ],
    );

    blocTest<PaginatedListBloc, PaginatedListState>(
      'emit [PaginatedListLoaded] with new result Page added to the last when the event FetchNextResultsPageEvent trigger for the second time and page number incremented',
      build: () {
        setUpMockFetchNextResultsPageSuccess();
        return paginatedListBloc;
      },
      act: (bloc) => bloc
        ..add(const FetchNextResultsPageEvent())
        ..add(const FetchNextResultsPageEvent()),
      skip: 1,
      expect: () => [
        PaginatedListLoaded(nextResultsPage: (tUsers + tUsers), page: 2),
        PaginatedListLoaded(nextResultsPage: (tUsers + tUsers), page: 3),
      ],
    );

    blocTest<PaginatedListBloc, PaginatedListState>(
      'emit [PaginatedListLoading,PaginatedListError] when getting data fails',
      build: () {
        setUpMockFetchNextResultsPageFailure(ServerFailure());
        return paginatedListBloc;
      },
      act: (bloc) => bloc.add(const FetchNextResultsPageEvent()),
      expect: () => [
        PaginatedListLoading(),
        const PaginatedListError(message: SERVER_FAILURE_MESSAGE)
      ],
    );

    blocTest<PaginatedListBloc, PaginatedListState>(
      'emit [PaginatedListLoading,PaginatedListError] with a proper message for the error when getting data fails',
      build: () {
        setUpMockFetchNextResultsPageFailure(CacheFailure());
        return paginatedListBloc;
      },
      act: (bloc) => bloc.add(const FetchNextResultsPageEvent()),
      expect: () => [
        PaginatedListLoading(),
        const PaginatedListError(message: CACHE_FAILURE_MESSAGE)
      ],
    );
  });

  group('SearchResultsEvent', () {
    const tQuery = "Thomas";
    const tUsers = [
      User(
        name: Name(firstName: "Thomas", lastName: "Jefferson"),
        dob: Dob(age: 46),
        email: "thomas.jeff@gmail.com",
        phoneNumber: "20302030203",
        profilePicture: Picture(urlPhotoMediumSize: "https:photo.png"),
        location: Location(
          city: "Washington",
          street: Street(number: "23", name: "Burger st"),
          postCode: "23832",
        ),
      ),
      User(
        name: Name(firstName: "Stephen", lastName: "Hawkins"),
        dob: Dob(age: 57),
        email: "steph.hawk@gmail.com",
        phoneNumber: "20302044277",
        profilePicture: Picture(urlPhotoMediumSize: "https:photo.jpg"),
        location: Location(
          city: "New York",
          street: Street(number: "57", name: "Lincoln st"),
          postCode: "74954",
        ),
      ),
    ];
    final tSearchResults = tUsers.where((results) =>
        ("${results.name.firstName} ${results.name.lastName}")
            .startsWith(tQuery));

    blocTest<PaginatedListBloc, PaginatedListState>(
      'emit [PaginatedListLoading,PaginatedListLoaded] when data is gotten successfully with no change in page number and change in nextResultsPage',
      build: () {
        paginatedListBloc.resultsPage = tUsers;
        return paginatedListBloc;
      },
      act: (bloc) => bloc.add(const SearchResultsEvent(query: tQuery)),
      expect: () => [
        PaginatedListLoading(),
        PaginatedListLoaded(nextResultsPage: tSearchResults.toList(), page: 1),
      ],
    );
  });

  group('RefreshResultsEvent', () {
    const tUsers = [
      User(
        name: Name(firstName: "Thomas", lastName: "Jefferson"),
        dob: Dob(age: 46),
        email: "thomas.jeff@gmail.com",
        phoneNumber: "20302030203",
        profilePicture: Picture(urlPhotoMediumSize: "https:photo.png"),
        location: Location(
          city: "Washington",
          street: Street(number: "23", name: "Burger st"),
          postCode: "23832",
        ),
      ),
      User(
        name: Name(firstName: "Stephen", lastName: "Hawkins"),
        dob: Dob(age: 57),
        email: "steph.hawk@gmail.com",
        phoneNumber: "20302044277",
        profilePicture: Picture(urlPhotoMediumSize: "https:photo.jpg"),
        location: Location(
          city: "New York",
          street: Street(number: "57", name: "Lincoln st"),
          postCode: "74954",
        ),
      ),
    ];

    blocTest<PaginatedListBloc, PaginatedListState>(
      'emit [PaginatedListLoading,PaginatedListLoaded] when data is gotten successfully with no change in page number and nextResultsPage',
      build: () {
        paginatedListBloc.resultsPage = tUsers;
        return paginatedListBloc;
      },
      act: (bloc) => bloc.add(const RefreshResultsEvent()),
      expect: () => [
        PaginatedListLoading(),
        const PaginatedListLoaded(nextResultsPage: tUsers, page: 1),
      ],
    );
  });
}
