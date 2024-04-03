import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_task/core/cache_helper/cache_helper.dart';
import 'package:promina_task/core/methods/navigation.dart';
import 'package:promina_task/core/methods/show_snack_bar.dart';
import 'package:promina_task/core/utils/app_assets.dart';
import 'package:promina_task/core/utils/app_constants.dart';
import 'package:promina_task/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:promina_task/features/auth/presentation/manager/auth_cubit/auth_states.dart';
import 'package:promina_task/features/auth/presentation/view/login_view.dart';
import 'package:promina_task/features/home/presentation/manager/get_user_gallery_cubit/get_user_gallery_cubit.dart';
import 'package:promina_task/features/home/presentation/manager/upload_image_cubit/upload_image_cubit.dart';
import 'package:promina_task/features/home/presentation/manager/upload_image_cubit/upload_image_states.dart';
import 'package:promina_task/features/home/presentation/view/widgets/dialog_widget.dart';
import 'package:promina_task/features/home/presentation/view/widgets/gallery_grid_view.dart';
import 'package:promina_task/features/home/presentation/view/widgets/setting_widget.dart';

import '../../../../core/utils/app_styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<UploadImageCubit, UploadImageStates>(
      listener: (context, state) async {
        if (state is PickImageSuccessState) {
          UploadImageCubit.get(context).uploadImage(state.path);
          navigatePop(context: context);
        }
        if (state is UploadImageSuccessfullyState) {
          await GetUserGalleryCubit.get(context).getUserGallery();
          showSnackBar(
            context: context,
            label: 'Successfully',
            color: AppConstants.primaryColor,
          );
        }
        if (state is UploadImageErrorState) {
          navigatePop(context: context);
          showSnackBar(
            context: context,
            label: state.error,
            color: Colors.red.shade200,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                AppAssets.homeBackgroundImage,
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<AuthCubit, AuthStates>(
                                builder: (context, state) {
                              return Expanded(
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  'Welcome \n ${CacheHelper.getData(key: 'name')}',
                                  style: AppStyles.style32,
                                ),
                              );
                            }),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Container(
                                  height: 100,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(AppAssets.person),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * .02.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SettingWidget(
                              onPressed: () {
                                navigateAndRemoveUntil(
                                    context: context,
                                    screen: const LoginView());
                                CacheHelper.removeData(key: 'token');
                                CacheHelper.removeData(key: 'name');
                              },
                              label: 'log out',
                              vector: AppAssets.vector1,
                              color: Colors.red,
                              shadowColor: Colors.red.shade200,
                            ),
                            SettingWidget(
                              onPressed: () {
                                showDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (_) {
                                    return const DialogWidget();
                                  },
                                );
                              },
                              label: 'upload',
                              vector: AppAssets.vector2,
                              color: const Color(0XFFFF9900),
                              shadowColor: const Color(0XFFFF9900),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: screenSize.height * .04.h,
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: screenSize.height * .04.h),
                        child: BlocBuilder<UploadImageCubit, UploadImageStates>(
                          builder: (context, state) {
                            if (state is UploadImageLoadingState) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: AppConstants.primaryColor,
                              ));
                            }
                            return GalleryGridView();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
