import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';


class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;


  const AppTextField({
    required this.prefixIcon,
    required this.suffixIcon,
    super.key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 16,
          fontWeight: FontWeight.w400
        ),
        border:  OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide.none,
          ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide.none,

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide(color: AppColors.primary, width: AppSizes.categoryBorderWidth),
        ),
        filled: true,
        fillColor: AppColors.surface,
        suffixIcon: suffixIcon ,
        prefixIcon: prefixIcon,

      ),
    );
  }
}