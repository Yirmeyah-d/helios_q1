import '../../domain/entities/name.dart';

class NameModel extends Name {
  const NameModel({
    required String firstName,
    required String lastName,
  }) : super(
          firstName: firstName,
          lastName: lastName,
        );

  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(
      firstName: json["first"] ?? json["firstName"],
      lastName: json["last"] ?? json["lastName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
