import '../../domain/entities/location.dart';
import 'street_model.dart';

class LocationModel extends Location {
  const LocationModel({
    required String city,
    required StreetModel street,
    required String postCode,
  }) : super(
          city: city,
          street: street,
          postCode: postCode,
        );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      city: json["city"],
      street: StreetModel.fromJson(json["street"]),
      postCode: json["postCode"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'postCode': postCode,
    };
  }
}
