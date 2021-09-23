part of 'image_bloc.dart';

class ImageState {
  final String image;

  ImageState({this.image = ''});

  ImageState copyWith({required String image}) => ImageState(image: image);
}

//----upload image transaction----//
class LoadingUploadImageState extends ImageState {}

class UploadImageSuccess extends ImageState {}

class FailUploadImage extends ImageState {
  final String error;

  FailUploadImage({required this.error});
}
