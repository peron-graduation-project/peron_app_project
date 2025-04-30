import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';

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
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.all(20),
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
                      color: Color(0xFF006A4E),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                ' رأيك يهمنا! شارك تقييمك',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.primaryFontFamily,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'وساعد غيرك يختار صح!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18, 
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.primaryFontFamily,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRating = index + 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SvgPicture.asset(
                        selectedRating > index 
                          ? "assets/icons/star.svg" 
                          : "assets/icons/starborder.svg",
                        width: 30,
                        height: 30,
                        color: Color(0xFF006A4E),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}