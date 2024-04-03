import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../manager/get_user_gallery_cubit/get_user_gallery_cubit.dart';
import '../../manager/get_user_gallery_cubit/get_user_gallery_states.dart';
import 'gallary_image_item.dart';

class GalleryGridView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocBuilder<GetUserGalleryCubit, GetUserGalleryStates>(
      buildWhen: (previous, current) =>
      previous != current ||
          current is GetUserGalleryLoadingState ||
          current is GetUserGallerySuccessfullyState ||
          current is GetUserGalleryErrorState,
      builder: (context, state) {
        if (state is GetUserGalleryLoadingState) {
          return const Center(
              child: CircularProgressIndicator(
                backgroundColor: AppConstants.primaryColor,
              ));
        }
        if (state is GetUserGalleryErrorState) {
          return Center(child: Text(state.error));
        }
        if (state is GetUserGallerySuccessfullyState) {
          return GridView.count(
            shrinkWrap: true,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: screenSize.width * .03,
            mainAxisSpacing: screenSize.height * .025,
            physics:
            const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            children: GetUserGalleryCubit.get(context)
                .galleryImages
                .map((image) => GallaryImageItem(
              image: image,
            ))
                .toList(),
          );
        }
        return Container();
      },
    );
  }
}