import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m3loma_app/features/auth/presentation/pages/login_page.dart';
import 'package:m3loma_app/features/profile/presentation/pages/views/settings_view.dart';
import '../../../../../core/services/local_profile_image_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/animated_backgrounds/animated_background.dart';
import 'edit_profile_view.dart';
import 'help_support.dart';
import 'my_certificates.dart';
import 'notifications.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final image = LocalProfileImageService.instance.getProfileImage();
  File? _profileImage;
  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final image =
    await LocalProfileImageService.instance.getProfileImage();

    if (!mounted) return;

    setState(() {
      _profileImage = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              CircleAvatar(
                radius: 60.r,
                backgroundColor: AppColors.primary,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : null,
                child: _profileImage == null
                    ? Icon(
                  Icons.person,
                  size: 60.r,
                  color: AppColors.textPrimary,
                )
                    : null,
              ),              SizedBox(height: 10.h),
              AnimatedBackground(
                type: AnimatedBackgroundType.fluidGradient,
                child: Text(
                  maxLines: 2,
                  user?.displayName ?? 'M3loma Student',                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                user?.email ?? '',                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryText.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: 20.h),
               _ProfileTile(
                 onTab: () async {
                   await Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const EditProfileView(),
                     ),
                   );

                   await _loadProfileImage();

                   await FirebaseAuth.instance.currentUser?.reload();

                   if (!mounted) return;

                   setState(() {});
                 },

                icon: Icons.edit_outlined,
                title: "Edit Profile",
              ),
               _ProfileTile(
                 onTab:(){ Navigator.push(context,
                   MaterialPageRoute(builder: (context) =>  MyCertificates()));},
                icon: Icons.card_membership_outlined,
                title: "My Certificates",
              ),
               _ProfileTile(
                 onTab:(){ Navigator.push(context,
                     MaterialPageRoute(builder: (context) =>  Notifications()));},
                icon: Icons.notifications_outlined,
                title: "Notifications",
              ),
               _ProfileTile(
                 onTab: (){ Navigator.push(context,
                     MaterialPageRoute(builder: (context) =>  SettingsView()));},
                icon: Icons.settings_outlined,
                title: "Settings",
              ),
               _ProfileTile(
                 onTab: (){ Navigator.push(context,
                     MaterialPageRoute(builder: (context) =>  HelpSupport()));},
                icon: Icons.help_outline,
                title: "Help & Support",
              ),
               _ProfileTile(
                 onTab: (){ Navigator.push(context,
                     MaterialPageRoute(builder: (context) =>  LoginPage()));},
                icon: Icons.logout_outlined,
                title: "Logout",
              ),
              SizedBox(height: 10.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("About App :",

                        style: AppTextStyles.titleMedium.copyWith(
                          fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.titleMedium.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: "M3loma",
                            style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                           TextSpan(
                            text:
                            " is a simple learning platform that helps you discover courses, "
                                "learn new skills, and grow your knowledge.",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("About Developer :",

                        style: AppTextStyles.titleMedium.copyWith(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.titleMedium.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: "This App was proudly developed with passion and countless lines of code by the humble servant of Allah,",
                            style:  TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                           TextSpan(
                            text:
                            " Mohamed Monge❤️",
                            style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTab;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.medium,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.medium,
        child: ListTile(
          leading: Icon(
            icon,
            color: AppColors.primary,
          ),
          title: Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: AppColors.primary,
            size: 24.r,
          ),
          onTap: onTab,
        ),
      ),
    );
  }
}