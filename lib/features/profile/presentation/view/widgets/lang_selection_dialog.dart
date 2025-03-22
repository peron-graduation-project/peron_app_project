import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

class LanguageSelectionDialog extends StatelessWidget {
  const LanguageSelectionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: size.width * 0.85,
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: isSmallScreen ? 16 : 20,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.025),

              Container(
                width: size.width * 0.2,
                height: size.width * 0.2,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/language.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.025),

              Text(
                'اختر اللغة',
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18, 
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: size.height * 0.025),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop('en');
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primaryColor),
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.015
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'English',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: size.width * 0.025),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop('ar');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.015
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'العربية',
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: isSmallScreen ? 14 : 16
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.025),
            ],
          ),
        ),
      ),
    );
  }
}
