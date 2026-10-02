import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m3loma_app/core/widgets/app_button.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/services/local_profile_image_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/presentation/cubit/update_profile_cubit.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final ImagePicker _picker = ImagePicker();
  final LocalProfileImageService _localImageService =
      LocalProfileImageService.instance;

  File? _profileImage;
  User? _user;

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _user = FirebaseAuth.instance.currentUser;

    _nameController = TextEditingController(text: _user?.displayName ?? '');

    _emailController = TextEditingController(text: _user?.email ?? '');

    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final image = await _localImageService.getProfileImage();

    if (!mounted || image == null) return;

    setState(() {
      _profileImage = image;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return;

    final file = File(image.path);

    setState(() {
      _profileImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: updateProfileCubit,
      child: Builder(
        builder: (context) {
          return BlocListener<UpdateProfileCubit, UpdateProfileState>(
            listener: (context, state) {
              if (state is UpdateProfileSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully'),
                  ),
                );

                Navigator.pop(context);
              }

              if (state is UpdateProfileFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                scrolledUnderElevation: 0,
                centerTitle: true,
                backgroundColor: AppColors.background,
                elevation: 0,
                title:  Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: AppColors.primary,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Center(
                      child: SizedBox(
                        width: 200.r,
                        height: 200.r,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 100.r,
                                backgroundColor: AppColors.primary,
                                backgroundImage: _profileImage != null
                                    ? FileImage(_profileImage!)
                                    : (_user?.photoURL != null
                                        ? NetworkImage(_user!.photoURL!)
                                        : null),
                                child: _profileImage == null &&
                                        _user?.photoURL == null
                                    ? Icon(
                                        Icons.person,
                                        size: 64.r,
                                        color: AppColors.textPrimary,
                                      )
                                    : null,
                              ),
                            ),
                            Positioned(
                              right: 10.w,
                              bottom: 5.h,
                              child: _CameraButton(onTap: _pickImage),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    AppTextField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      hintStyle: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      backgroundColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        size: 30,
                        color: AppColors.primary,
                      ),
                      suffixIcon: null,
                      obscureText: false,
                      hintText: 'Your Name',
                    ),
                    SizedBox(height: 20.h),
                    AppTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      hintStyle: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      backgroundColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        size: 30,
                        color: AppColors.primary,
                      ),
                      suffixIcon: null,
                      obscureText: false,
                      hintText: 'Your Email',
                    ),
                    const Spacer(),
                    AppButton(
                      variant: AppButtonVariant.danger,
                      label: 'Delete Account',
                      onPressed: () {},
                    ),
                    SizedBox(height: 20.h),
                    AppButton(
                      label: 'Update Profile',
                      onPressed: () async {
                        final user = _user;
                        if (user == null) return;
                        final cubit = context.read<UpdateProfileCubit>();

                        try {
                          if (_profileImage != null) {
                            final savedImage = await _localImageService
                                .saveProfileImage(_profileImage!);

                            if (!mounted) return;

                            setState(() {
                              _profileImage = File(savedImage);
                            });
                          }

                          final userModel = UserModel(
                            id: user.uid,
                            name: user.displayName ?? '',
                            email: user.email ?? '',
                            phone: '',
                            image: user.photoURL,
                          );

                          cubit.updateProfile(
                            user: userModel,
                            name: _nameController.text,
                            email: _emailController.text,
                          );
                        } catch (e, stackTrace) {
                          debugPrint('EDIT PROFILE ERROR: $e');
                          debugPrintStack(stackTrace: stackTrace);
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CameraButton extends StatefulWidget {
  final VoidCallback onTap;

  const _CameraButton({required this.onTap});

  @override
  State<_CameraButton> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<_CameraButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        scale: _isPressed ? 0.88 : 1.0,
        child: Container(
          width: 60.r,
          height: 60.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            border: Border.all(
              color: AppColors.background,
              width: 3.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 35.r,
          ),
        ),
      ),
    );
  }
}
