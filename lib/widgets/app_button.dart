import 'package:flutter/material.dart';
import 'package:taskmanager/widgets/app_color.dart';
import 'package:taskmanager/widgets/app_text_style.dart';

class AppNavigationButton extends StatelessWidget {
  final String buttonHeading;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color headingColor;
  final Widget? icon;

  const AppNavigationButton({
    super.key,
    required this.buttonHeading,
    required this.onPressed,
    this.backgroundColor = AppColor.buttonColor,
    this.headingColor = AppColor.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(99),
          ),
          elevation: 0,
        ),
        child: icon == null
            ? Text(buttonHeading, style: AppTextStyle.buttonTextStyle)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconTheme(
                    data: const IconThemeData(color: AppColor.white),
                    child: icon!,
                  ),
                  const SizedBox(width: 8),
                  Text(buttonHeading, style: AppTextStyle.buttonTextStyle),
                ],
              ),
      ),
    );
  }
}
