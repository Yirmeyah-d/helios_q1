import 'package:helios_q1/src/features/paginated_list/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String firstName,
    required String lastName,
    required int age,
    required String email,
    required String phoneNumber,
    required String city,
    required String street,
    required String postCode,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          age: age,
          email: email,
          phoneNumber: phoneNumber,
          city: city,
          street: street,
          postCode: postCode,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json[""],
      lastName: json[""],
      age: json[""],
      email: json[""],
      phoneNumber: json[""],
      city: json[""],
      street: json[""],
      postCode: json[""],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'street': street,
      'postCode': postCode,
    };
  }
}
