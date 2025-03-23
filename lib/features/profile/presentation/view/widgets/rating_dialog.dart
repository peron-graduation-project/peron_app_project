import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

class RatingDialog extends StatefulWidget {
  final Function(int)? onRatingSubmit;

  const RatingDialog({Key? key, this.onRatingSubmit}) : super(key: key);

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    final closeIconSize = isSmallScreen ? 18.0 : 22.0;
    final titleFontSize = isSmallScreen ? 16.0 : 18.0;
    final descriptionFontSize = isSmallScreen ? 13.0 : 14.0;
    final starSize = isSmallScreen ? 30.0 : 36.0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
        vertical: 24,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    if (mounted) {
                      Navigator.pop(context, selectedRating);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: closeIconSize,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              Image.asset(
                'assets/images/review.png',
                height: size.height * 0.25,
                fit: BoxFit.contain,
              ),

              SizedBox(height: size.height * 0.03),

              Text(
                'هل أنت مستمتع باستخدام ابليكيشن بيرون؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: size.height * 0.01),

              Text(
                'رأيك يهمنا فشاركنا تقييمك',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: descriptionFontSize,
                  color: Colors.grey.shade600,
                ),
              ),

              SizedBox(height: size.height * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRating = index + 1;
                      });

                      if (widget.onRatingSubmit != null) {
                        widget.onRatingSubmit!(index + 1);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        selectedRating > index ? Icons.star : Icons.star_border,
                        color: AppColors.primaryColor,
                        size: starSize,
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
