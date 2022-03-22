import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:helios_q1/src/core/error/exceptions.dart';
import 'package:helios_q1/src/features/paginated_list/data/data_sources/paginated_list_remote_data_source.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'paginated_list_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late PaginatedListRemoteDataSourceImpl dataSource;
  late MockDio mockDio;
  final Dio dio;

  setUp(() {
    mockDio = MockDio();
    dataSource = PaginatedListRemoteDataSourceImpl(dio: mockDio);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockDio.get(any)).thenAnswer((_) async => Response(
          data: jsonDecode(fixture('results_page.json')),
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ));
  }

  void setUpMockHttpClientFailure404() {
    when(mockDio.get(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
        ));
  }

  group('fetchNextResultsPage', () {
    const tPage = 1;

    final tUserModels = (jsonDecode(fixture('results_page.json'))["results"])
        .map((resultsPage) => UserModel.fromJson(resultsPage))
        .toList();
    test(
      '''should perform a GET request on a URL with
         page argument''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.fetchNextResultsPage(tPage);
        // assert
        verify(mockDio
            .get('https://randomuser.me/api/?page=$tPage&results=20&seed=abc'));
      },
    );

    test(
      'should return UserModels when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        final result = await dataSource.fetchNextResultsPage(tPage);
        // assert
        expect(result, equals(tUserModels));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.fetchNextResultsPage;
        // assert
        expect(
            () => call(tPage), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
