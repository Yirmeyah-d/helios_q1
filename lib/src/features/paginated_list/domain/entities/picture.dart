import 'package:equatable/equatable.dart';

class Picture extends Equatable {
  final String urlPhotoMediumSize;

  const Picture({
    required this.urlPhotoMediumSize,
  });

  @override
  List<Object> get props => [
        urlPhotoMediumSize,
      ];
}
