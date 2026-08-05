import 'package:flutter/material.dart';
import 'package:taskmanager/widgets/app_color.dart';

class AppTextStyle {
  static const TextStyle headingStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColor.textColor,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColor.textColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: AppColor.textColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColor.white,
  );
}
