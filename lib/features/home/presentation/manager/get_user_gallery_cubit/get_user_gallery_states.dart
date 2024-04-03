abstract class GetUserGalleryStates{}

class GetUserGalleryInitialState extends GetUserGalleryStates{}

class GetUserGalleryLoadingState extends GetUserGalleryStates{}
class GetUserGallerySuccessfullyState extends GetUserGalleryStates{
  final List<String> images ;
  GetUserGallerySuccessfullyState(this.images);
}
class GetUserGalleryErrorState extends GetUserGalleryStates{
  final String error ;
  GetUserGalleryErrorState(this.error);
}