import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_styles.dart';

//ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Color backgroundColor ;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.backgroundColor ,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        color: backgroundColor,
        onPressed: onPressed,
        minWidth: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 7.h,
        ),
        child: Text(
          label,
          style: AppStyles.style18,
        ),
      ),
    );
  }
}
