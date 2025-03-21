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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(20),
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
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Image.asset('assets/images/review.png', height: 150),

              const SizedBox(height: 20),

              const Text(
                'هل أنت مستمتع باستخدام ابلكيشن بيرون؟',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                'رأيك يهمنا فشاركنا تقييمك',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 20),

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
                      size: 30,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
