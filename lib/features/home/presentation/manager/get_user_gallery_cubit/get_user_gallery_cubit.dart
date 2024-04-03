import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/home_repo.dart';
import 'get_user_gallery_states.dart';

class GetUserGalleryCubit extends Cubit<GetUserGalleryStates> {
  final HomeRepo homeRepo;

  GetUserGalleryCubit(this.homeRepo) : super(GetUserGalleryInitialState());

  static GetUserGalleryCubit get(context) =>
      BlocProvider.of<GetUserGalleryCubit>(context);

  List<String> galleryImages = [];
  getUserGallery() async {
    emit(GetUserGalleryLoadingState());
    galleryImages = [];
    // emit(GetUserGalleryLoadingState());
    var data = await homeRepo.getUserGallery();
    data.fold(
      (failure) => emit(GetUserGalleryErrorState(failure.errorMessage)),
      (images) {
        galleryImages = images;
        emit(GetUserGallerySuccessfullyState(images));
      },
    );
  }
}
