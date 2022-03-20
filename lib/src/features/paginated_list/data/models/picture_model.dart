import '../../domain/entities/picture.dart';

class PictureModel extends Picture {
  const PictureModel({
    required String urlPhotoMediumSize,
  }) : super(
          urlPhotoMediumSize: urlPhotoMediumSize,
        );

  factory PictureModel.fromJson(Map<String, dynamic> json) {
    return PictureModel(
      urlPhotoMediumSize: json["medium"] ?? json["urlPhotoMediumSize"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'urlPhotoMediumSize': urlPhotoMediumSize,
    };
  }
}
