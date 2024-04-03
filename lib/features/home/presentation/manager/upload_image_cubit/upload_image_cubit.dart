import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promina_task/features/home/presentation/manager/upload_image_cubit/upload_image_states.dart';

import '../../../data/repos/home_repo.dart';

class UploadImageCubit extends Cubit<UploadImageStates> {
  final HomeRepo homeRepo;

  UploadImageCubit(this.homeRepo) : super(UploadImageInitialState());

  static UploadImageCubit get(context) =>
      BlocProvider.of<UploadImageCubit>(context);

  void pickImage(ImageSource source) async {
    emit(PickImageLoadingState());
    final XFile? image = await ImagePicker().pickImage(source: source);
    emit(PickImageSuccessState(image!.path));
  }

  void uploadImage(String imagePath) async {
    emit(UploadImageLoadingState());
    var data = await homeRepo.uploadImage(imagePath: imagePath);
    data.fold(
      (failure) => emit(UploadImageErrorState(failure.errorMessage)),
      (success) => emit(UploadImageSuccessfullyState()),
    );
  }
}

// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:promina_task/features/home/presentation/manager/upload_image_cubit/upload_image_states.dart';
//
//
// class UploadImageCubit extends Cubit<UploadImageStates>{
//   UploadImageCubit() : super(UploadImageInitialState());
//
//   XFile? imageFile;
//   final picker = ImagePicker();
//
//   Future<void> getImageFromGallery() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         imageFile = pickedFile;
//         print(imageFile!.path);
//             // XFile(pickedFile.path);
//         emit(PickImageSuccessState());
//         // await postImageToAPI();
//       } else {
//         print('No image selected.');
//       }
//
//   }
//
//   Future<void> getImageFromCamera() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//       if (pickedFile != null) {
//         imageFile = XFile(pickedFile.path);
//         postImageToAPI();
//       } else {
//         print('No image selected.');
//       }
//   }
//
//   Future<void> postImageToAPI() async {
//     emit(UploadImageLoadingState());
//     if (imageFile == null) {
//       print('No image selected.');
//       return;
//     }
//
//     final String url = 'upload'; // Replace this with your actual API endpoint
//
//     Dio dio = Dio();
//     FormData formData = FormData.fromMap({
//       'img': await MultipartFile.fromFile(imageFile!.path),
//     });
//
//     try {
//        await dio.post(url, data: formData,options: Options(headers: {
//          "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDVmNDNlYmNjZDE5MDEyNmM0YTFiMDM2ZTA1ODI1ZWI4ODMwYWQwODgzMDAzOTk1N2JiNmZhMzk4NDQxNDE3ZmViMmQ2MDQzYzcyYWFhOTkiLCJpYXQiOjE3MTIxMDM4OTEuMzU2Mzc0LCJuYmYiOjE3MTIxMDM4OTEuMzU2Mzc2LCJleHAiOjE3NDM2Mzk4OTEuMzU1NjAzLCJzdWIiOiIyMjUiLCJzY29wZXMiOltdfQ.GhTU2H5DfSFt51r3MkRt9MhW_tc75uNTSa_LzgAAHuuolrcCJ8LZp3TuCy-Zptz1DxGI3yhcf4wraf-4_PU34w8ULQgMjX5dmHvKWf9IL0tfeE9YydTpJJpcY7dq7qY8WSR7KjAUS7HL9ILFVj_rswN06HzKG3bv4_yEzMwWi3c34okj-BuWvRteG8_MiVZzFH8MMMsQpx9U1ADtAB-8VYNHLjHAV_0d6dCB1m2JcCB5vSiJGleiu06JIw2Hh3eah3TDgT7hffxO27RyH7nJQ7aelKriB3ot11qjI8foa2Q-aG5qpARl_xMndqSzUWxXWkRSxu2Px2gh8kq54zoz8OylEboxdKqZWBGLsX6QMy_ovPpFD9B4qjOgIrNBS8Suxk-Z5WOHwv4-QpaVvQkhzRnWj_Eq1pmhONQ--CFS6sn-9jFmW66xqG7RRnzRdugpQmiHdnUu7-2ins6gf-3KeGoWJyI_zrrJ9WKbHAz14H5bJlLCwCujQ1hhUmIW9zj5bYGVyGy1tb5Gv5_lVSVsJsh7sWNvKNdX47zu6BpwRZ4gtmn36FKaU9EYikXz-YrLpUBdHM-pVZHDdfzNQUa43rv3s4v4l7ET6pj-t1JB8WgajWzKeCsOLLwxfd6tvfUSvWRp8s_NtSb2pu3G11rGjF8LzshGm60Uvi3T7WCRUF8"
//        }));
//       emit(UploadImageSuccessfullyState());
//     } catch (e) {
//       emit(UploadImageErrorState());
//     }
//   }
// }
