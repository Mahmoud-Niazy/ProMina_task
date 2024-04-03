import 'package:get_it/get_it.dart';
import 'package:promina_task/features/home/data/repos/home_repo.dart';
import 'package:promina_task/features/home/data/repos/home_repo_imp.dart';

import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/data/repos/auth_repo_imp.dart';
import '../api_services/api_services.dart';

final serviceLocator = GetIt.instance;

class ServiceLocator {
  static init() {
    /// Api Services
    serviceLocator.registerLazySingleton<ApiServices>(
      () => ApiServices(),
    );

    /// Repos
    serviceLocator.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<HomeRepo>(
      () => HomeRepoImp(serviceLocator()),
    );
  }
}
