import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/storage_service.dart';
import '../../../../core/theme/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../domain/models/onboarding_item.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;
  int _currentPage = 0;

  static const List<OnboardingItem> _items = [
    OnboardingItem(
      title: "Discover Courses",
      subtitle: "Explore Useful Knowledge",
      description:
          "Browse through a wide range of interactive courses and learn topics tailored to your exact career and educational goals.",
      animationAsset: AppAssets.onboardingDiscover,
    ),
    OnboardingItem(
      title: "Learn & Improve",
      subtitle: "Build High-Demand Skills",
      description:
          "Study at your own comfortable pace with structured lessons, practical exercises, and guidance anytime, anywhere.",
      animationAsset: AppAssets.onboardingLearn,
    ),
    OnboardingItem(
      title: "Start Learning",
      subtitle: "Achieve Your Growth",
      description:
          "Take the first step towards mastering new skills today with M3loma. Your learning journey starts now!",
      animationAsset: AppAssets.onboardingStart,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    await StorageService.instance.setOnboardingCompleted(true);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>  LoginPage(),
      ),
    );
  }

  void _onNextPressed() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _items.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: isLastPage
                    ? SizedBox(height: 40.h)
                    : TextButton(
                        onPressed: _completeOnboarding,
                        child: Text(
                          "Skip",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingContent(item: _items[index]);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
              child: Column(
                children: [
                  PageIndicator(
                    count: _items.length,
                    currentIndex: _currentPage,
                  ),
                  SizedBox(height: 28.h),
                  AppButton(
                    label: isLastPage ? "Get Started" : "Next",
                    onPressed: _onNextPressed,
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
