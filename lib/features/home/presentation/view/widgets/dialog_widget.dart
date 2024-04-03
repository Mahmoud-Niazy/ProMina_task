import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promina_task/features/home/presentation/manager/upload_image_cubit/upload_image_cubit.dart';
import '../../../../../core/utils/app_assets.dart';
import 'option_item.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          height: screenSize.height * .3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                color: Colors.white.withOpacity(.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OptionWidget(
                      label: 'Gallery',
                      vector: AppAssets.gallery,
                      onPressed: () {
                        UploadImageCubit.get(context).pickImage(
                          ImageSource.gallery,
                        );
                      },
                    ),
                    SizedBox(
                      height: screenSize.height * .04,
                    ),
                    OptionWidget(
                      label: 'Camera',
                      vector: AppAssets.camera,
                      onPressed: () {
                        UploadImageCubit.get(context).pickImage(
                          ImageSource.camera,
                        );

                        // UploadImageCubit().postImageToAPI();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
