import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_task/core/api_services/api_services.dart';
import 'package:promina_task/core/service_locator/service_locator.dart';
import 'package:promina_task/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:promina_task/features/auth/presentation/view/login_view.dart';
import 'package:promina_task/features/home/presentation/manager/get_user_gallery_cubit/get_user_gallery_cubit.dart';
import 'package:promina_task/features/home/presentation/manager/upload_image_cubit/upload_image_cubit.dart';
import 'package:promina_task/features/home/presentation/view/home_view.dart';
import 'core/cache_helper/cache_helper.dart';
import 'features/auth/data/repos/auth_repo.dart';
import 'features/home/data/repos/home_repo.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    const MyApp(),
  );
  await ServiceLocator.init();
  ApiServices.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    return ScreenUtilInit(
      builder: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => AuthCubit(serviceLocator<AuthRepo>())),
            BlocProvider(create: (context)=> UploadImageCubit(serviceLocator<HomeRepo>())),
            BlocProvider(create: (context) => GetUserGalleryCubit(serviceLocator<HomeRepo>())..getUserGallery())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: token != null ? const HomeView() : const LoginView(),
          ),
        );
      },
    );
  }
}
