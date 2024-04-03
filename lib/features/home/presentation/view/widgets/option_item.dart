import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';

class OptionWidget extends StatelessWidget {
  final String label;
  final String vector;

  final void Function()? onPressed;

  const OptionWidget({
    super.key,
    required this.label,
    required this.vector,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        height: screenSize.height * .06,
        width: screenSize.width * .35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(vector),
            SizedBox(
              width: screenSize.width * .02,
            ),
            Text(
              label,
              style: AppStyles.style20,
            ),
            SizedBox(
              width: screenSize.width * .02,
            ),
          ],
        ),
      ),
    );
  }
}
