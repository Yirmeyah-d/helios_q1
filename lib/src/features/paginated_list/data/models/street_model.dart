import '../../domain/entities/street.dart';

class StreetModel extends Street {
  const StreetModel({
    required String number,
    required String name,
  }) : super(
          number: number,
          name: name,
        );

  factory StreetModel.fromJson(Map<String, dynamic> json) {
    return StreetModel(
      number: json["number"].toString(),
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
    };
  }
}
