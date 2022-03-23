import 'package:equatable/equatable.dart';
import 'dob.dart';
import 'location.dart';
import 'name.dart';
import 'picture.dart';

class User extends Equatable {
  final Name name;
  final Dob dob;
  final String email;
  final String phoneNumber;
  final Picture profilePicture;
  final Location location;

  const User({
    required this.name,
    required this.dob,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.location,
  });

  @override
  List<Object> get props => [
        name,
        dob,
        email,
        phoneNumber,
        profilePicture,
        location,
      ];

  Map<String, dynamic> toMap() {
    return {
      'name': "${name.firstName} ${name.lastName}",
      'age': dob.age,
      "email": email,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture.urlPhotoMediumSize,
      "city": location.city,
      "street": "${location.street.number} ${location.street.name}",
      "postCode": location.postCode,
    };
  }
}
