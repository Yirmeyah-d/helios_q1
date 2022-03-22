import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:helios_q1/src/features/paginated_list/domain/repositories/paginated_list_repository.dart';
import 'package:helios_q1/src/features/paginated_list/domain/use_cases/fetch_next_result_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/dob_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/location_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/name_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/picture_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/street_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/user_model.dart';
import 'fetch_next_result_page_test.mocks.dart';

@GenerateMocks([PaginatedListRepository])
void main() {
  // initialization outside of setUp
  const tPageOne = 1;
  final tUserModelsOne = [
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
  const tPageTwo = 2;
  final tUserModelsTwo = [
    const UserModel(
      name: NameModel(firstName: "Jamie", lastName: "Lannister"),
      dob: DobModel(age: 42),
      email: "jam.lann@gmail.com",
      phoneNumber: "278372302",
      profilePicture: PictureModel(urlPhotoMediumSize: "https:photo-jamie.png"),
      location: LocationModel(
        city: "New Fields",
        street: StreetModel(number: "77", name: "Throne st"),
        postCode: "26329",
      ),
    ),
  ];
  final mockPaginatedListRepository = MockPaginatedListRepository();
  final useCase = FetchNextResultsPage(mockPaginatedListRepository);

  test(
    'should get result page for the page number 1 from the repository',
    () async {
      //arrange
      when(mockPaginatedListRepository.fetchNextResultsPage(1))
          .thenAnswer((_) async => Right(tUserModelsOne));
      // act
      final result = await useCase(Params(page: tPageOne));
      // assert
      expect(result, Right(tUserModelsOne));
      verify(mockPaginatedListRepository.fetchNextResultsPage(tPageOne));
      verifyNoMoreInteractions(mockPaginatedListRepository);
    },
  );

  test(
    'should get result page containing the result of the page 1 and 2 from the repository',
    () async {
      //arrange
      final tUserModels = tUserModelsOne + tUserModelsTwo;
      when(mockPaginatedListRepository.fetchNextResultsPage(1))
          .thenAnswer((_) async => Right(tUserModelsOne));
      when(mockPaginatedListRepository.fetchNextResultsPage(2))
          .thenAnswer((_) async => Right(tUserModels));
      // act
      final result = await useCase(const Params(page: tPageTwo));
      // assert
      expect(result, Right(tUserModels));
      verify(mockPaginatedListRepository.fetchNextResultsPage(tPageTwo));
      verifyNoMoreInteractions(mockPaginatedListRepository);
    },
  );
}
