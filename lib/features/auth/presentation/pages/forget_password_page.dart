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
      appBar: AppBar(
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
              prefixIcon: Icon(Icons.email_outlined, size: 35),
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