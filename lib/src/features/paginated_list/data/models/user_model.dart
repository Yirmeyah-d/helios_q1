import 'package:helios_q1/src/features/paginated_list/data/models/dob_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/location_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/name_model.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/picture_model.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required NameModel name,
    required DobModel dob,
    required String email,
    required String phoneNumber,
    required PictureModel profilePicture,
    required LocationModel location,
  }) : super(
          name: name,
          dob: dob,
          email: email,
          phoneNumber: phoneNumber,
          profilePicture: profilePicture,
          location: location,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: NameModel.fromJson(json["name"]),
      dob: DobModel.fromJson(json["dob"]),
      email: json["email"],
      phoneNumber: json["phone"] ?? json["phoneNumber"],
      profilePicture:
          PictureModel.fromJson(json["picture"] ?? json["profilePicture"]),
      location: LocationModel.fromJson(json["location"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dob': dob,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'location': location,
    };
  }
}
