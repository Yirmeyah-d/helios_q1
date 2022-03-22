import 'package:flutter_test/flutter_test.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/dob.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/location.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/name.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/picture.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/street.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/user.dart';

void main() {
  const tUser = User(
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
  );

  group('toMap', () {
    test(
      'should return a Map containing the proper data',
      () async {
        // act
        final result = tUser.toMap();

        // assert
        final expectedMap = {
          'name': "${tUser.name.firstName} ${tUser.name.lastName}",
          'age': tUser.dob.age,
          "email": tUser.email,
          "phoneNumber": tUser.phoneNumber,
          "profilePicture": tUser.profilePicture.urlPhotoMediumSize,
          "city": tUser.location.city,
          "street":
              "${tUser.location.street.number} ${tUser.location.street.name}",
          "postCode": tUser.location.postCode,
        };

        expect(result, expectedMap);
      },
    );
  });
}
