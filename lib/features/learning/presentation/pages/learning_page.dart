import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/animated_backgrounds/animated_background.dart';
import '../../../../core/widgets/app_button.dart';

class LearningPage extends StatefulWidget {
  final String courseTitle;

  const LearningPage({
    super.key,
    required this.courseTitle,
  });

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  int _currentLessonIndex = 0;

  static const List<Map<String, String>> _lessons = [
    {"title": "01. Introduction & Overview", "duration": "12 mins"},
    {"title": "02. Setting Up Environment", "duration": "18 mins"},
    {"title": "03. Core Principles & Architecture", "duration": "24 mins"},
    {"title": "04. Hands-on Project Implementation", "duration": "35 mins"},
  ];

  @override
  Widget build(BuildContext context) {
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
          widget.courseTitle,
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
            // Video Player Container
            Container(
              height: 200.h,
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.play_circle_fill_outlined,
                    size: 64.r,
                    color: AppColors.primary,
                  ),
                  Positioned(
                    bottom: 12.h,
                    left: 16.w,
                    right: 16.w,
                    child: LinearProgressIndicator(
                      value: (_currentLessonIndex + 1) / _lessons.length,
                      color: AppColors.primary,
                      backgroundColor: Colors.white24,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBackground(
                      type: AnimatedBackgroundType.shimmerWave,
                      child: Text(
                        _lessons[_currentLessonIndex]["title"]!,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Lesson ${_currentLessonIndex + 1} of ${_lessons.length} • ${_lessons[_currentLessonIndex]["duration"]}",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    Text(
                      "Course Content",
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _lessons.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == _currentLessonIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentLessonIndex = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withValues(alpha: 0.2)
                                  : AppColors.surface,
                              borderRadius: AppRadius.small,
                              border: isSelected
                                  ? Border.all(color: AppColors.primary, width: 1.5)
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.play_circle_fill
                                      : Icons.play_circle_outline,
                                  color: AppColors.primary,
                                  size: 24.r,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    _lessons[index]["title"]!,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  _lessons[index]["duration"]!,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Controls
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              child: Row(
                children: [
                  if (_currentLessonIndex > 0)
                    Expanded(
                      child: AppButton(
                        label: "Previous",
                        variant: AppButtonVariant.outlined,
                        onPressed: () {
                          setState(() {
                            _currentLessonIndex--;
                          });
                        },
                      ),
                    ),
                  if (_currentLessonIndex > 0) SizedBox(width: 12.w),
                  Expanded(
                    child: AppButton(
                      label: _currentLessonIndex < _lessons.length - 1
                          ? "Next Lesson"
                          : "Finish Lesson",
                      onPressed: () {
                        if (_currentLessonIndex < _lessons.length - 1) {
                          setState(() {
                            _currentLessonIndex++;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Congratulations! Lesson completed."),
                            ),
                          );
                        }
                      },
                    ),
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
