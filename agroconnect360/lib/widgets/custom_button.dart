import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? color;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppColors.primary;

    if (isOutlined) {
      return OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: buttonColor, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        icon: isLoading
            ? SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
                ),
              )
            : Icon(icon ?? Icons.check, color: buttonColor),
        label: Text(
          text,
          style: TextStyle(color: buttonColor, fontWeight: FontWeight.w600),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      icon: isLoading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.textWhite),
              ),
            )
          : Icon(icon ?? Icons.check, color: AppColors.textWhite),
      label: Text(
        text,
        style: const TextStyle(
          color: AppColors.textWhite,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
