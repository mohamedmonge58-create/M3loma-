import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

void showTopSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final topMargin = MediaQuery.of(context).padding.top + 12;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.error,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        top: topMargin,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).size.height - topMargin - 80,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final topMargin = MediaQuery.of(context).padding.top + 12;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.success,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        top: topMargin,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).size.height - topMargin - 80,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}
