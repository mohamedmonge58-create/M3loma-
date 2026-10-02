import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            showSuccessSnackBar(
              context,
              "Account created successfully!",
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }
          if (state is AuthFailure) {
            showTopSnackBar(context, state.message);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            centerTitle: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            title: const Text(
              'Register',
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
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: Lottie.asset(
                        'assets/animations/register.json',
                        fit: BoxFit.contain,
                        repeat: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextField(
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      controller: _nameController,
                      backgroundColor: null,
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.person_outline, size: 35 , color: Colors.white70,),
                      suffixIcon: null,
                      obscureText: false,
                      hintText: "Your Name",
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: _emailController,
                      backgroundColor: null,
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon( Icons.email_outlined, size: 35 , color: Colors.white70,),
                      suffixIcon: null,
                      obscureText: false,
                      hintText: "Your Email",
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      backgroundColor: null,
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.lock_outline, size: 35 , color: Colors.white70,),
                      suffixIcon:
                          const Icon(Icons.remove_red_eye_outlined, size: 35 , color: Colors.white70,),
                      obscureText: true,
                      hintText: "Password",
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      controller: _confirmPasswordController,
                      backgroundColor: null,
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.lock_outline, size: 35 , color: Colors.white70,),
                      suffixIcon:
                          const Icon(Icons.remove_red_eye_outlined, size: 35 , color: Colors.white70,),
                      obscureText: true,
                      hintText: "Confirm Password",
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      controller: _phoneController,
                      backgroundColor: null,
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.call, size: 35 , color: Colors.white70,),
                      suffixIcon: null,
                      obscureText: false,
                      hintText: "Your Phone Number",
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return AppButton(
                          label: "Create Account",
                          isLoading: state is AuthLoading,
                          isEnabled: state is! AuthLoading,
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            authCubit.register(
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                              name: _nameController.text.trim(),
                              phone: _phoneController.text.trim(),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
