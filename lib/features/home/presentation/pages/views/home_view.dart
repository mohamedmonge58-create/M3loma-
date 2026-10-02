import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/services/local_profile_image_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/animated_backgrounds/animated_background.dart';
import '../../../../auth/presentation/cubit/update_profile_cubit.dart';

class TopicModel {
  final String label;
  final IconData icon;

  const TopicModel({
    required this.label,
    required this.icon,
  });
}

class CourseModel {
  final String title;
  final String category;
  final String instructor;
  final double rating;
  final String duration;
  final IconData icon;

  const CourseModel({
    required this.title,
    required this.category,
    required this.instructor,
    required this.rating,
    required this.duration,
    this.icon = Icons.school,
  });
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _selectedTopic = "Programming";
  File? _profileImage;
  User? _user;
  StreamSubscription<User?>? _userSubscription;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();

    // Listen to real-time Firebase Auth user profile changes (name, photo, etc.)
    _userSubscription = FirebaseAuth.instance.userChanges().listen((user) {
      if (mounted) {
        setState(() {
          _user = user;
        });
      }
    });
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadProfileImage() async {
    final image = await LocalProfileImageService.instance.getProfileImage();
    final currentUser = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (_profileImage?.path != image?.path ||
        _user?.displayName != currentUser?.displayName ||
        _user?.photoURL != currentUser?.photoURL) {
      setState(() {
        _profileImage = image;
        _user = currentUser;
      });
    }
  }

  static const List<TopicModel> _topics = [
    TopicModel(label: "Programming", icon: Icons.code),
    TopicModel(label: "Business", icon: Icons.business_center),
    TopicModel(label: "AI & Data", icon: Icons.auto_awesome),
    TopicModel(label: "Mobile Development", icon: Icons.phone_android),
    TopicModel(label: "Web Development", icon: Icons.language),
    TopicModel(label: "Graphic Design", icon: Icons.palette),
    TopicModel(label: "Marketing", icon: Icons.campaign),
    TopicModel(label: "Photography", icon: Icons.camera_alt),
  ];

  static const List<CourseModel> _allCourses = [
    CourseModel(
      title: "Clean Architecture in Dart",
      category: "Programming",
      instructor: "Mohamed Monge",
      rating: 5.0,
      duration: "12 hours",
      icon: Icons.code,
    ),
    CourseModel(
      title: "Flutter & Dart Masterclass",
      category: "Programming",
      instructor: "Eng. Monge",
      rating: 4.8,
      duration: "16 hours",
      icon: Icons.phone_android,
    ),
    CourseModel(
      title: "EdTech Product Management",
      category: "Business",
      instructor: "Karim Said",
      rating: 4.8,
      duration: "10 hours",
      icon: Icons.business_center,
    ),
    CourseModel(
      title: "Startup Growth Strategy",
      category: "Business",
      instructor: "Nour Eslam",
      rating: 4.6,
      duration: "7 hours",
      icon: Icons.trending_up,
    ),
    CourseModel(
      title: "Python for Data Science & AI",
      category: "AI & Data",
      instructor: "Dr. Ahmed Zaki",
      rating: 4.9,
      duration: "14 hours",
      icon: Icons.auto_awesome,
    ),
    CourseModel(
      title: "Machine Learning Fundamentals",
      category: "AI & Data",
      instructor: "Mona Mahmoud",
      rating: 4.8,
      duration: "11 hours",
      icon: Icons.psychology,
    ),
    CourseModel(
      title: "Flutter Mobile Apps Masterclass",
      category: "Mobile Development",
      instructor: "Mohamed Monge",
      rating: 5.0,
      duration: "20 hours",
      icon: Icons.phone_android,
    ),
    CourseModel(
      title: "iOS Development with Swift",
      category: "Mobile Development",
      instructor: "Hassan Ali",
      rating: 4.7,
      duration: "15 hours",
      icon: Icons.apple,
    ),
    CourseModel(
      title: "Full-Stack Web Development",
      category: "Web Development",
      instructor: "Omar Khalid",
      rating: 4.9,
      duration: "22 hours",
      icon: Icons.language,
    ),
    CourseModel(
      title: "React & Next.js Pro",
      category: "Web Development",
      instructor: "Youssef Nabil",
      rating: 4.8,
      duration: "18 hours",
      icon: Icons.web,
    ),
    CourseModel(
      title: "UI/UX Design Essentials",
      category: "Graphic Design",
      instructor: "Sarah Ahmed",
      rating: 4.9,
      duration: "8 hours",
      icon: Icons.palette,
    ),
    CourseModel(
      title: "Figma Design System to Code",
      category: "Graphic Design",
      instructor: "Ali Hassan",
      rating: 4.7,
      duration: "6 hours",
      icon: Icons.brush,
    ),
    CourseModel(
      title: "Digital Marketing Strategy",
      category: "Marketing",
      instructor: "Laila Sherif",
      rating: 4.7,
      duration: "9 hours",
      icon: Icons.campaign,
    ),
    CourseModel(
      title: "Social Media Advertising",
      category: "Marketing",
      instructor: "Tarek Reda",
      rating: 4.6,
      duration: "5 hours",
      icon: Icons.share,
    ),
    CourseModel(
      title: "Professional Photography & Editing",
      category: "Photography",
      instructor: "Khaled Samy",
      rating: 4.9,
      duration: "10 hours",
      icon: Icons.camera_alt,
    ),
  ];

  List<CourseModel> get _filteredCourses {
    return _allCourses
        .where((course) => course.category == _selectedTopic)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    _loadProfileImage();

    final displayName =
        (_user?.displayName != null && _user!.displayName!.trim().isNotEmpty)
            ? _user!.displayName!
            : "M3loma Learner";

    return BlocProvider.value(
      value: updateProfileCubit,
      child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) async {
          if (state is UpdateProfileSuccess) {
            await FirebaseAuth.instance.currentUser?.reload();
            await _loadProfileImage();
            if (mounted) {
              setState(() {
                _user = FirebaseAuth.instance.currentUser;
              });
            }
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back 👋",
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primaryText.withValues(alpha: 0.7),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          AnimatedBackground(
                            type: AnimatedBackgroundType.movingGradient,
                            child: Text(
                              displayName,
                              style: AppTextStyles.titleLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: AppColors.primary,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : (_user?.photoURL != null
                                ? NetworkImage(_user!.photoURL!)
                                : null),
                        child: _profileImage == null && _user?.photoURL == null
                            ? Icon(
                                Icons.person,
                                color: AppColors.textPrimary,
                                size: 30.r,
                              )
                            : null,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Banner Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppRadius.medium,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedBackground(
                          type: AnimatedBackgroundType.glowPulse,
                          opacity: 0.35,
                          colors: const [Colors.white24, Colors.white10],
                          child: Text(
                            "Continue Learning",
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Master Flutter & Dart for Mobile App Development",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textPrimary.withValues(alpha: 0.85),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        LinearProgressIndicator(
                          value: 0.65,
                          backgroundColor: Colors.white24,
                          color: AppColors.background,
                          borderRadius: AppRadius.small,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "65% Completed",
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Quick Categories / Topics
                  AnimatedBackground(
                    type: AnimatedBackgroundType.floatingBlobs,
                    child: Text(
                      "Popular Topics",
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _topics.length,
                      itemBuilder: (context, index) {
                        final topic = _topics[index];
                        return _TopicChip(
                          label: topic.label,
                          icon: topic.icon,
                          isSelected: topic.label == _selectedTopic,
                          onTap: () {
                            setState(() {
                              _selectedTopic = topic.label;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Courses List based on selected Topic
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedBackground(
                        type: AnimatedBackgroundType.breathingBackground,
                        child: Text(
                          "$_selectedTopic Courses",
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "${_filteredCourses.length} items",
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primaryText.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredCourses.length,
                    separatorBuilder: (context, index) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      return _CourseCard(course: _filteredCourses[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopicChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TopicChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        isSelected ? AppColors.textPrimary : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: AppRadius.small,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18.r,
              color: textColor,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: textColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final CourseModel course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.medium,
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: AppRadius.small,
            ),
            child: Icon(
              course.icon,
              color: AppColors.primary,
              size: 28.r,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  course.instructor,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16.r),
                    SizedBox(width: 4.w),
                    Text(
                      "${course.rating}",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Icon(Icons.access_time, color: AppColors.textSecondary, size: 16.r),
                    SizedBox(width: 4.w),
                    Text(
                      course.duration,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
