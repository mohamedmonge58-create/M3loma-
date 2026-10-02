import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

class LoadingWidget extends StatelessWidget {
  final int count;

  const LoadingWidget({
    super.key,
    this.count = 3,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.surface,
          highlightColor: AppColors.surface.withValues(alpha: 0.5),
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.medium,
            ),
          ),
        );
      },
    );
  }
}
