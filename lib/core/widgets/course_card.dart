import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String instructor;
  final double rating;
  final String duration;
  final IconData icon;
  final double? progress;
  final String? lessonsText;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.instructor,
    required this.rating,
    required this.duration,
    this.icon = Icons.school,
    this.progress,
    this.lessonsText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.medium,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52.w,
              height: 52.h,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: AppRadius.small,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 26.r,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    instructor,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  if (progress != null) ...[
                    LinearProgressIndicator(
                      value: progress!,
                      color: AppColors.primary,
                      backgroundColor: AppColors.background,
                      borderRadius: AppRadius.small,
                    ),
                    SizedBox(height: 6.h),
                  ],
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 15.r),
                      SizedBox(width: 4.w),
                      Text(
                        "$rating",
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Icon(Icons.access_time, color: AppColors.textSecondary, size: 15.r),
                      SizedBox(width: 4.w),
                      Text(
                        duration,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (lessonsText != null) ...[
                        const Spacer(),
                        Text(
                          lessonsText!,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
