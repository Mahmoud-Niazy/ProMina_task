import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:promina_task/core/api_services/api_services.dart';

import 'package:promina_task/core/failure/failure.dart';

import 'package:promina_task/features/auth/data/models/user_model.dart';

import 'auth_repo.dart';

class AuthRepoImp extends AuthRepo {
  final ApiServices apiServices;

  AuthRepoImp(this.apiServices);

  @override
  Future<Either<Failure, UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiServices.postData(
        path: 'auth/login',
        data: {
          'email': email,
            'password': password,
        },
      );
      if (response.data['error_message'] == null) {
        UserModel userData = UserModel.fromJson(response.data);
        return right(userData);
      } else {
        throw (response.data['error_message']);
      }
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      } else {
        return left(Failure(error.toString()));
      }
    }
  }
}
