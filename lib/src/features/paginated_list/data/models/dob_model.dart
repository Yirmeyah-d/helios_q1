import '../../domain/entities/dob.dart';

class DobModel extends Dob {
  const DobModel({
    required int age,
  }) : super(
          age: age,
        );

  factory DobModel.fromJson(Map<String, dynamic> json) {
    return DobModel(
      age: json["age"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
    };
  }
}
