import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/animated_backgrounds/animated_background.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/course_preview_player.dart';
import '../../../learning/presentation/pages/learning_page.dart';

class CourseDetailsPage extends StatelessWidget {
  final String title;
  final String instructor;
  final double rating;
  final String duration;
  final String? previewVideoUrl;

  const CourseDetailsPage({
    super.key,
    required this.title,
    required this.instructor,
    required this.rating,
    required this.duration,
    this.previewVideoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveVideoUrl = previewVideoUrl ??
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Course Details",
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Hero Preview Player with short demo video
                    CoursePreviewPlayer(
                      videoUrl: effectiveVideoUrl,
                      courseTitle: title,
                    ),
                    SizedBox(height: 20.h),

                    // Title with Animated Light Sweep Background
                    AnimatedBackground(
                      type: AnimatedBackgroundType.lightSweep,
                      child: Text(
                        title,
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Instructor
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16.r,
                          backgroundColor: AppColors.primary,
                          child: Icon(Icons.person, color: Colors.white, size: 18.r),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          instructor,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Metadata Badges
                    Row(
                      children: [
                        _Badge(
                          icon: Icons.star,
                          label: "$rating Rating",
                          iconColor: Colors.amber,
                        ),
                        SizedBox(width: 12.w),
                        _Badge(
                          icon: Icons.access_time,
                          label: duration,
                          iconColor: AppColors.primary,
                        ),
                        SizedBox(width: 12.w),
                        _Badge(
                          icon: Icons.menu_book,
                          label: "28 Lessons",
                          iconColor: AppColors.primary,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Course Description
                    Text(
                      "About This Course",
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Comprehensive curriculum designed to master modern concepts step-by-step. Includes practical projects, quizzes, and a certificate of completion.",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Lessons Overview
                    Text(
                      "Curriculum",
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    const _LessonTile(
                      number: "01",
                      title: "Course Overview & Objectives",
                      duration: "12 mins",
                    ),
                    const _LessonTile(
                      number: "02",
                      title: "Architecture & Design Patterns",
                      duration: "24 mins",
                    ),
                    const _LessonTile(
                      number: "03",
                      title: "Building Real-World Components",
                      duration: "35 mins",
                    ),
                  ],
                ),
              ),
            ),

            // Bottom CTA
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              child: AppButton(
                label: "Start Course Now",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LearningPage(courseTitle: title),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _Badge({
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.small,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 16.r),
          SizedBox(width: 4.w),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final String number;
  final String title;
  final String duration;

  const _LessonTile({
    required this.number,
    required this.title,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.small,
      ),
      child: Row(
        children: [
          Text(
            number,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  duration,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.play_circle_fill, color: AppColors.primary, size: 24.r),
        ],
      ),
    );
  }
}
