import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/animated_backgrounds/animated_background.dart';
import '../../../../../core/widgets/course_card.dart';
import '../../../../../core/widgets/empty_state.dart';
import '../../../../course_details/presentation/pages/course_details_page.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  static const List<Map<String, dynamic>> _allCourses = [
    {
      "title": "Clean Architecture in Dart",
      "category": "Mobile Dev",
      "instructor": "Mohamed Monge",
      "rating": 5.0,
      "duration": "12 hours",
      "icon": Icons.code,
    },
    {
      "title": "Flutter & Dart Masterclass",
      "category": "Mobile Dev",
      "instructor": "Eng. Monge",
      "rating": 4.8,
      "duration": "16 hours",
      "icon": Icons.phone_android,
    },
    {
      "title": "UI/UX Design Essentials",
      "category": "Graphic Design",
      "instructor": "Sarah Ahmed",
      "rating": 4.9,
      "duration": "8 hours",
      "icon": Icons.palette,
    },
    {
      "title": "Figma Design System to Code",
      "category": "Graphic Design",
      "instructor": "Ali Hassan",
      "rating": 4.7,
      "duration": "6 hours",
      "icon": Icons.brush,
    },
    {
      "title": "Full-Stack Web Development",
      "category": "Web Dev",
      "instructor": "Omar Khalid",
      "rating": 4.9,
      "duration": "22 hours",
      "icon": Icons.language,
    },
    {
      "title": "React & Next.js Pro",
      "category": "Web Dev",
      "instructor": "Youssef Nabil",
      "rating": 4.8,
      "duration": "18 hours",
      "icon": Icons.web,
    },
    {
      "title": "Python for Data Science & AI",
      "category": "Data Science",
      "instructor": "Dr. Ahmed Zaki",
      "rating": 4.9,
      "duration": "14 hours",
      "icon": Icons.auto_awesome,
    },
    {
      "title": "Machine Learning Fundamentals",
      "category": "Data Science",
      "instructor": "Mona Mahmoud",
      "rating": 4.8,
      "duration": "11 hours",
      "icon": Icons.psychology,
    },
    {
      "title": "Cyber Security Fundamentals",
      "category": "Cyber Security",
      "instructor": "Mostafa Reda",
      "rating": 4.7,
      "duration": "10 hours",
      "icon": Icons.security,
    },
  ];

  List<Map<String, dynamic>> get _filteredCourses {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return [];
    return _allCourses.where((course) {
      final title = (course["title"] as String).toLowerCase();
      final instructor = (course["instructor"] as String).toLowerCase();
      final category = (course["category"] as String).toLowerCase();
      return title.contains(query) ||
          instructor.contains(query) ||
          category.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = _searchQuery.trim().isNotEmpty;
    final results = _filteredCourses;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBackground(
                type: AnimatedBackgroundType.fluidGradient,
                child: Text(
                  "Discover Courses",
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
                cursorColor: AppColors.primary,
                decoration: InputDecoration(
                  hintText: "Search courses, topics or instructors...",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.primary,
                  ),
                  suffixIcon: isSearching
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: AppColors.primary),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = "";
                            });
                          },
                        )
                      : const Icon(Icons.tune, color: AppColors.primary),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.medium,
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              if (isSearching) ...[
                // Search Results Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedBackground(
                      type: AnimatedBackgroundType.breathingBackground,
                      child: Text(
                        "Search Results",
                        style: AppTextStyles.titleMedium.copyWith(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "${results.length} found",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primaryText.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Search Results List / Empty State
                Expanded(
                  child: results.isNotEmpty
                      ? ListView.separated(
                          itemCount: results.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final course = results[index];
                            return CourseCard(

                              title: course["title"],
                              instructor: course["instructor"],
                              rating: course["rating"],
                              duration: course["duration"],
                              icon: course["icon"],

                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CourseDetailsPage(
                                      title: course["title"],
                                      instructor: course["instructor"],
                                      rating: course["rating"],
                                      duration: course["duration"],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : EmptyStateWidget(
                    descriptionColor: AppColors.primary,

                          icon: Icons.search_off,
                          title: "No Courses Found",

                          description:
                              "No courses matched '$_searchQuery'. Try searching for another course name or topic.",


                          actionLabel: "Clear Search",
                          onAction: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = "";
                            });
                          },
                        ),
                ),
              ] else ...[
                // Default Categories View
                Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedBackground(
                    type: AnimatedBackgroundType.breathingBackground,
                    child: Text(
                      "Explore Categories",
                      style: AppTextStyles.titleMedium.copyWith(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 1.2,
                    children: [
                      _CategoryCard(
                        title: "Mobile Dev",
                        icon: Icons.phone_android,
                        count: "42 Courses",
                        onTap: () {
                          setState(() {
                            _searchController.text = "Mobile Dev";
                            _searchQuery = "Mobile Dev";
                          });
                        },
                      ),
                      _CategoryCard(
                        title: "Web Dev",
                        icon: Icons.code,
                        count: "58 Courses",
                        onTap: () {
                          setState(() {
                            _searchController.text = "Web Dev";
                            _searchQuery = "Web Dev";
                          });
                        },
                      ),
                      _CategoryCard(
                        title: "Data Science",
                        icon: Icons.bar_chart,
                        count: "31 Courses",
                        onTap: () {
                          setState(() {
                            _searchController.text = "Data Science";
                            _searchQuery = "Data Science";
                          });
                        },
                      ),
                      _CategoryCard(
                        title: "Cyber Security",
                        icon: Icons.security,
                        count: "24 Courses",
                        onTap: () {
                          setState(() {
                            _searchController.text = "Cyber Security";
                            _searchQuery = "Cyber Security";
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String count;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.medium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 32.r),
            SizedBox(height: 12.h),
            Text(
              title,
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              count,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
