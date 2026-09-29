import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/services/storage_service.dart';
import '../../../../core/theme/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../onboarding/presentation/pages/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        if (!mounted) return;
        final bool isCompleted =
            StorageService.instance.isOnboardingCompleted();
        final Widget destination =
            isCompleted ? const LoginPage() : const OnboardingPage();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => destination,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                AppAssets.splashScreen,
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Text(
              "Supervised by Mohamed Monge",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
