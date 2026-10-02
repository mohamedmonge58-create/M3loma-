import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool obscureText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final Color? backgroundColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const AppTextField({
    required this.style,
    required this.keyboardType,
    required this.hintStyle,
    required this.prefixIcon,
    required this.suffixIcon,
    super.key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
    required this.backgroundColor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: style,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        border: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide(
            color: AppColors.primary,
            width: AppSizes.categoryBorderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppSizes.categoryBorderWidth,
          ),
        ),
        errorStyle: const TextStyle(
          color: AppColors.error,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: backgroundColor ?? AppColors.surface,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
