import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/widgets/custom_button.dart';

import '../../../../../core/widgets/build_text_form_field.dart';
import '../../../../../core/widgets/custom_arrow_back.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var theme=Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "كلمة السر الجديدة",
        style: theme.headlineMedium,
        ),
        centerTitle: true,
        leading: CustomArrowBack(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05,vertical: size.height*0.03),
        child: ListView(
          children: [
          Center(
            child: SvgPicture.asset(
              Images.newPassword,
            ),
          ),
            SizedBox(height: size.height * 0.04),
            buildTextField("كلمة السر", TextInputType.visiblePassword, obscureText: true),
            SizedBox(height: size.height * 0.03),
            buildTextField("تأكيد كلمة السر", TextInputType.visiblePassword, obscureText: true),

            SizedBox(height: size.height * 0.05),
        CustomButton(textColor: Colors.white, text:"تأكيد", backgroundColor: AppColors.primaryColor,
        onPressed: (){
          _showSuccessDialog(context);
        },
        )   ,     ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF0F7757), size: 75),
              const SizedBox(height: 10),
              const Text(
                "تم تغيير كلمة المرور",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              const Text(
                "تم تغيير كلمة المرور الخاصة بك بنجاح",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomButton(textColor: Colors.white, text: 'تسجيل الدخول', backgroundColor: AppColors.primaryColor,
                onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        PageRouteName.login,
                            arguments: false,
                            (route) => false,
                      );},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
