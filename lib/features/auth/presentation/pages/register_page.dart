import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(color: AppColors.primary , fontWeight: FontWeight.bold , fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.primary,

      ),),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
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
              SizedBox(height: 10),
              AppTextField(
                prefixIcon: Icon(Icons.person_outline, size: 35),
                suffixIcon: null,
                obscureText: false,
                hintText: "Your Name",
              ),
              SizedBox(height: 24),
          
              AppTextField(
                prefixIcon: Icon(Icons.email_outlined, size: 35),
                suffixIcon: null,
                obscureText: false,
                hintText: "Your Email",
              ),
              SizedBox(height: 24),
          
              AppTextField(
                prefixIcon: Icon(Icons.lock_outline, size: 35),
                suffixIcon: Icon(Icons.remove_red_eye_outlined, size: 35),
                obscureText: true,
                hintText: "Password",
              ),
              SizedBox(height: 24),
          
              AppTextField(
                prefixIcon: Icon(Icons.lock_outline, size: 35),
                suffixIcon: Icon(Icons.remove_red_eye_outlined, size: 35),
                obscureText: true,
                hintText: "Confirm Password",
              ),
              SizedBox(height: 24),
          
              AppTextField(
                prefixIcon: Icon(Icons.call, size: 35),
                suffixIcon: null,
                obscureText: false,
                hintText: "Your Phone Number",
              ),
          
              SizedBox(height: 24),
              AppButton(label: "Create Account", onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage( ),
                    )
                );
          
              }),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
          
                children: [
                  Text("Already have an account?" ,style:  TextStyle(color: Colors.grey,fontSize: 14),),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("Login"
                      ,style: TextStyle(color: AppColors.primary,fontSize: 14,fontWeight: FontWeight.bold),))
                ],
              ),
          
            ]),
        ),
      ),
    );
  }
}
