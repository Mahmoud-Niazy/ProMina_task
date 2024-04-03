abstract class UploadImageStates {}

class UploadImageInitialState extends UploadImageStates{}

class PickImageLoadingState extends UploadImageStates{}
class PickImageSuccessState extends UploadImageStates{
  final String path ;
  PickImageSuccessState(this.path);
}

class UploadImageLoadingState extends UploadImageStates{}
class UploadImageSuccessfullyState extends UploadImageStates{}
class UploadImageErrorState extends UploadImageStates{
  final String error;
  UploadImageErrorState(this.error);
}