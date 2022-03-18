import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String firstName;
  final String lastName;
  final int age;
  final String email;
  final String phoneNumber;
  final String city;
  final String street;
  final String postCode;

  const User({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.street,
    required this.postCode,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
        city,
        street,
        postCode,
        age,
      ];
}
