import 'package:flutter/material.dart';
import 'package:promina_task/core/utils/app_constants.dart';

abstract class AppStyles{
  static const TextStyle style50 = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: AppConstants.textPrimaryColor,
  );

  static const TextStyle style30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppConstants.textPrimaryColor,
  );

  static const TextStyle style16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0XFF988F8C),
  );

  static const TextStyle style18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle style32 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: AppConstants.textPrimaryColor,
  );

  static const TextStyle style20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppConstants.textPrimaryColor,
  );
}