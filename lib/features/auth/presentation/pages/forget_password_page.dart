import 'package:flutter/material.dart';

import '../../../../core/theme/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
        title:  Text('Forget Password' ,style: TextStyle( color: AppColors.primary , fontWeight: FontWeight.bold , fontSize: 20 )),
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
        child: Column(
          children: [
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.asset(
                AppAssets.forgetPassword,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 24,),
            AppTextField(
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },

              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              hintStyle: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              backgroundColor: null,
              prefixIcon: Icon(Icons.email_outlined, size: 35 , color: Colors.white70,),
              suffixIcon: null,
              obscureText: false,
              hintText: "Your Email",
            ),
            SizedBox(height: 24,),
            AppButton(label: "Verify Email", onPressed: (){})





          ],
        ),
      ),
    );
  }
}