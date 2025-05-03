import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';

class ChatpotViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: CustomArrowBack(),
          title: Text(
            "مساعد بيرون",
            style: theme.headlineMedium!.copyWith(fontSize: screenWidth * 0.05),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.04),
                        SvgPicture.asset(
                          "assets/icons/icons8-chatgpt.svg",
                          color: AppColors.grey,
                          height: screenHeight * 0.12,
                          width: screenWidth * 0.2,
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        Text(
                          'خدمات المساعد الذكي',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.025),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: screenHeight * 0.055,
                                width: screenWidth * 0.85,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.02,
                                  ),
                                ),
                                child: Text(
                                  'ابحث عن شقق للإيجار بسهولة.',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.038,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              Container(
                                height: screenHeight * 0.055,
                                width: screenWidth * 0.85,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.02,
                                  ),
                                ),
                                child: Text(
                                  'استفسر عن الأسعار والشروط بكل سهولة.',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.038,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              Text(
                                'هذه مجرد أمثلة لما أستطيع القيام به لمساعدتك.',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: screenWidth * 0.035,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(fontSize: screenWidth * 0.038),
                          decoration: InputDecoration(
                            hintText: 'استفسر عن أي شيء',
                            hintStyle: TextStyle(
                              fontSize: screenWidth * 0.038,
                              color: Colors.grey[700],
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.03,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.03,
                              ),
                            ),
                            contentPadding: EdgeInsetsDirectional.only(
                              start: screenWidth * 0.04,
                              top: screenHeight * 0.015,
                              bottom: screenHeight * 0.015,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        height: screenWidth * 0.12,
                        width: screenWidth * 0.12,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: screenWidth * 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
