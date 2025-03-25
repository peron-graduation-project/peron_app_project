import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/custom_text_field.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/phone_number_field.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        return Scaffold(
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.07,
                  vertical: screenHeight * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/backicon.svg',
                            width: screenWidth * 0.06,
                            height: screenWidth * 0.06,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'تحتاج إلى مساعدة؟',
                              style: GoogleFonts.tajawal(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black, 
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.06),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'مرحبًا بك!',
                            style: GoogleFonts.tajawal(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary, 
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            'هل تحتاج إلى مساعدة؟ فريقنا جاهز للتواصل معك في أقرب وقت!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.tajawal(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey, 
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    CustomTextField(label: 'الاسم'),
                    CustomTextField(label: 'البريد الإلكتروني'),
                    CustomPhoneField(),
                    CustomTextField(label: 'الوصف / الاستفسار', maxLines: 3),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary, 
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.02,
                            ),
                          ),
                        ),
                        child: Text(
                          'إرسال',
                          style: GoogleFonts.tajawal(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white, 
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
