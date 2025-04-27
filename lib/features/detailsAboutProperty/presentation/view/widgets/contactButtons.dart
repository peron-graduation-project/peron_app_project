import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButtons extends StatelessWidget {
  final double standardPadding;
  final double regularFontSize;
  final double smallPadding;
  final double iconSize;
  final double screenHeight;

  const ContactButtons({
    Key? key,
    required this.standardPadding,
    required this.regularFontSize,
    required this.smallPadding,
    required this.iconSize,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: standardPadding,
            vertical: standardPadding * 0.75,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            textDirection: TextDirection.rtl,
            children: [
              SizedBox(width: standardPadding * 0.5),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    launchUrl(Uri.parse("mailto:example@email.com"));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    padding:
                        EdgeInsets.symmetric(vertical: standardPadding * 0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'الايميل',
                        style: TextStyle(
                          fontSize: regularFontSize,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: smallPadding),
                      Icon(Icons.email_outlined,
                          color: Colors.black54, size: iconSize),
                    ],
                  ),
                ),
              ),
              SizedBox(width: standardPadding * 0.5),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    launchUrl(Uri.parse("tel:+123456789"));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    padding:
                        EdgeInsets.symmetric(vertical: standardPadding * 0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'اتصال',
                        style: TextStyle(
                          fontSize: regularFontSize,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: smallPadding),
                      Icon(Icons.phone, color: Colors.black54, size: iconSize),
                    ],
                  ),
                ),
              ),
              SizedBox(width: standardPadding * 0.5),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    launchUrl(Uri.parse("https://wa.me/123456789"));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen.shade100,
                    padding:
                        EdgeInsets.symmetric(vertical: standardPadding * 0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Icon(Icons.chat, color: Colors.green, size: iconSize),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
      ],
    );
  }
}
