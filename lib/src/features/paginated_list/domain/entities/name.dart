import 'package:equatable/equatable.dart';

class Name extends Equatable {
  final String firstName;
  final String lastName;

  const Name({
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
      ];
}
