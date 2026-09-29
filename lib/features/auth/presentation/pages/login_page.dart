import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import 'forget_password_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                "Login \n        To Be Hero",

                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 35,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 180,
                height: 180,
                child: Lottie.asset(
                  'assets/animations/Unlocked.json',
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
              const SizedBox(height: 15),
               AppTextField(
                hintText: "Enter your Email ",
                obscureText: false,
                prefixIcon: Icon(Icons.email_outlined),
                suffixIcon: null,
              ),
              const SizedBox(height: 10),
               AppTextField(
                hintText: "Password",
                obscureText: true,
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => ForgetPasswordPage( ),
                      )
                  );

                }, child: Text("Forget Password?" ,
                    style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,


                ))),
              ),

              const SizedBox(height: 20),
              AppButton(label: "Login", onPressed: (){}),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?" ,style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  )),

                  TextButton(onPressed: (){
                    Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage( ),
                    )
                    );

                  }, child: Text("Create One" ,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,)))
                ],
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SizedBox(
                    width: 100,

                    child: Divider(

                      color: AppColors.primary,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "OR",
                      style: TextStyle(color: AppColors.primary, fontSize: 15,fontWeight: FontWeight. w700),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Divider(
                      color: AppColors.primary,
                      thickness: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              AppButton(
                  icon:Image.asset( AppAssets.googleIcon,width: 70,height: 70,),

                  label: "Login With Google", onPressed: (){}),


            ],
          ),
        ),
      ),
    );
  }
}