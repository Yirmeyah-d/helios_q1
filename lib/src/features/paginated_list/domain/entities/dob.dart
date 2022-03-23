import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Dob extends Equatable {
  final int age;

  const Dob({
    required this.age,
  });

  @override
  List<Object> get props => [
        age,
      ];
}
