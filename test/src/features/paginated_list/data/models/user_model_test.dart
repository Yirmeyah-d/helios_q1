import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/dob_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/location_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/name_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/user_model.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/user.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/picture_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/street_model.dart';

void main() {
  const tUserModel = UserModel(
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
  );

  test(
    'should be a subclass of Dob entity',
    () async {
      // assert
      expect(tUserModel, isA<User>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('user.json'));
        // act
        final result = UserModel.fromJson(jsonMap);
        // assert
        expect(result, tUserModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a Json map containing the proper data',
      () async {
        // act
        final result = tUserModel.toJson();

        // assert
        final expectedMap = {
          'name': NameModel(firstName: "Thomas", lastName: "Jefferson"),
          'dob': DobModel(age: 46),
          'email': "thomas.jeff@gmail.com",
          'phoneNumber': "20302030203",
          'profilePicture':
              const PictureModel(urlPhotoMediumSize: "https:photo.png"),
          'location': const LocationModel(
            city: "Washington",
            street: StreetModel(number: "23", name: "Burger st"),
            postCode: "23832",
          ),
        };

        expect(result, expectedMap);
      },
    );
  });
}
