import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:promina_task/core/api_services/api_services.dart';
import 'package:promina_task/core/failure/failure.dart';
import 'package:promina_task/features/home/data/repos/home_repo.dart';

import '../../../../core/cache_helper/cache_helper.dart';

class HomeRepoImp extends HomeRepo {
  final ApiServices apiServices;

  HomeRepoImp(this.apiServices);

  @override
  Future<Either<Failure, void>> uploadImage({required String imagePath}) async {
    try {
      final response = await ApiServices().postData(
        path: 'upload',
        data: FormData.fromMap({
          'img': await MultipartFile.fromFile(imagePath),
        }),
        token: CacheHelper.getData(key: 'token'),
      );
      if (response.statusCode == 200) {
        return right(null);
      } else {
        throw (response.data['message']);
      }
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      } else {
        return left(Failure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<String>>> getUserGallery() async {
    try {
      var response = await apiServices.getData(
        path: 'my-gallery',
        token: CacheHelper.getData(key: 'token'),
      );
      List<String> images = [];
      response['data']['images'].forEach((image) {
        images.add(image);
      });
      return right(images);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      } else {
        return left(Failure(error.toString()));
      }
    }
  }
}
