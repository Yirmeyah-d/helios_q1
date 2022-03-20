import 'package:equatable/equatable.dart';
import 'street.dart';

class Location extends Equatable {
  final String city;
  final Street street;
  final String postCode;

  const Location({
    required this.city,
    required this.street,
    required this.postCode,
  });

  @override
  List<Object> get props => [
        city,
        street,
        postCode,
      ];
}
