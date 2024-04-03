import 'package:dartz/dartz.dart';
import 'package:promina_task/features/auth/data/models/user_model.dart';

import '../../../../core/failure/failure.dart';

abstract class AuthRepo{
  Future<Either<Failure,UserModel>> signIn({
    required String email ,
    required String password
});
}