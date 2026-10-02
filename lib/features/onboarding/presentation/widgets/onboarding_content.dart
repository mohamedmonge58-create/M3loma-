import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/models/onboarding_item.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingContent({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300.h,
            width: double.infinity,
            alignment: Alignment.center,
            child: Lottie.asset(
              item.animationAsset,
              fit: BoxFit.contain,
              repeat: true,
            ),
          ),
          SizedBox(height: 36.h),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.onboardingWelcomeTitle.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 32.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            item.subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.onboardingTitle.copyWith(
              color: AppColors.primaryText,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primaryText.withValues(alpha: 0.75),
              height: 1.5,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
