import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';

class SettingWidget extends StatelessWidget {
  final Color color;
  final Color shadowColor;
  final String label;
  final String vector;

  final void Function()? onPressed;

  const SettingWidget({
    super.key,
    required this.label,
    required this.color,
    required this.shadowColor,
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
        height: 40,
        width: screenSize.width * .35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: screenSize.width * .09,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(-4, 0),
                      color: shadowColor,
                      blurRadius: 2),
                ],
              ),
              child: Image.asset(
                vector,
              ),
            ),
            SizedBox(
              width: screenSize.width * .02,
            ),
            Text(
              label,
              style: AppStyles.style20,
            ),
          ],
        ),
      ),
    );
  }
}
