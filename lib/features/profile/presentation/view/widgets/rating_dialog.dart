import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({Key? key}) : super(key: key);

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int selectedRating = 0;

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

              Image.asset(
                'assets/images/review.png', 
                height: size.height * 0.15
              ),

              SizedBox(height: size.height * 0.025),

              Text(
                'هل أنت مستمتع باستخدام ابلكيشن بيرون؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18, 
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: size.height * 0.012),

              Text(
                'رأيك يهمنا فشاركنا تقييمك',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 14, 
                  color: Colors.grey
                ),
              ),

              SizedBox(height: size.height * 0.025),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRating = index + 1;
                      });
                    },
                    child: Icon(
                      selectedRating > index ? Icons.star : Icons.star_border,
                      color: AppColors.primaryColor,
                      size: isSmallScreen ? 25 : 30,
                    ),
                  );
                }),
              ),

              SizedBox(height: size.height * 0.025),
            ],
          ),
        ),
      ),
    );
  }
}
