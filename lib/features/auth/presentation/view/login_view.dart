import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_task/core/cache_helper/cache_helper.dart';
import 'package:promina_task/core/methods/navigation.dart';
import 'package:promina_task/core/methods/show_snack_bar.dart';
import 'package:promina_task/core/utils/app_assets.dart';
import 'package:promina_task/core/utils/app_constants.dart';
import 'package:promina_task/core/utils/app_styles.dart';
import 'package:promina_task/core/widgets/custom_button.dart';
import 'package:promina_task/core/widgets/custom_text_form_field.dart';
import 'package:promina_task/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:promina_task/features/home/presentation/view/home_view.dart';
import '../manager/auth_cubit/auth_states.dart';

class LoginView extends StatelessWidget {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.loginBackgroundImage,
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'My \n Gallery',
                      style: AppStyles.style50,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: (screenSize.height * .05).h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .07.w,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                              vertical: 20.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(.5),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'LOG IN',
                                  style: AppStyles.style30,
                                ),
                                SizedBox(
                                  height: screenSize.height * .04.h,
                                ),
                                CustomTextFormField(
                                  isPassword: false,
                                  label: 'User Name',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email is empty';
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                ),
                                SizedBox(
                                  height: screenSize.height * .03.h,
                                ),
                                CustomTextFormField(
                                  isPassword: true,
                                  label: 'Password',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password is empty';
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                ),
                                SizedBox(
                                  height: screenSize.height * .05.h,
                                ),
                                BlocConsumer<AuthCubit, AuthStates>(
                                  listener: (context, state) async {
                                    if (state is UserLoginSuccessfullyState) {
                                      // print(state.userData.token);
                                      await CacheHelper.saveData(
                                          key: 'token',
                                          value: state.userData.token);
                                      await CacheHelper.saveData(
                                          key: 'name',
                                          value: state.userData.name);

                                      navigate(
                                          context: context,
                                          screen: const HomeView());
                                      showSnackBar(
                                        context: context,
                                        label: 'Successfully',
                                        color: AppConstants.primaryColor,
                                      );
                                      emptyFormFields();
                                    }
                                    if (state is UserLoginErrorState) {
                                      // print(state.error);
                                      showSnackBar(
                                        context: context,
                                        label: state.error,
                                        color: Colors.red.shade200,
                                      );
                                    }
                                    // print(state);
                                  },
                                  builder: (context, state) {
                                    if (state is UserLoginLoadingState) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor:
                                              AppConstants.primaryColor,
                                        ),
                                      );
                                    }
                                    return CustomButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          AuthCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                      label: 'SUBMIT',
                                      backgroundColor:
                                          AppConstants.primaryColor,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  emptyFormFields() {
    emailController.text = '';
    passwordController.text = '';
  }
}
