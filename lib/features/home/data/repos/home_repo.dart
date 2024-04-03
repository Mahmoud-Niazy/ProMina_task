import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, void>> uploadImage({
    required String imagePath,
  });

  Future<Either<Failure,List<String>>>getUserGallery();
}
