import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/chats/presentation/view/views/chat_body_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:peron_project/core/helper/fonts.dart';

class ContactButtons extends StatelessWidget {
  final double standardPadding;
  final double regularFontSize;
  final double smallPadding;
  final double iconSize;
  final double screenHeight;
  final Property property;

  ContactButtons({
    Key? key,
    required this.property,
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
        SizedBox(height: 10),
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => ChatBodyScreen(name:property.ownerId,image: null,)),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    padding: EdgeInsets.symmetric(
                      vertical: standardPadding * 0.8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'مراسلة',
                        style: TextStyle(
                          fontSize: regularFontSize,
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                      SizedBox(width: smallPadding),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    launchUrl(Uri.parse("tel:+123456789"));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    padding: EdgeInsets.symmetric(
                      vertical: standardPadding * 0.8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.black, size: iconSize),
                      SizedBox(width: smallPadding),

                      Text(
                        'اتصال',
                        style: TextStyle(
                          fontSize: regularFontSize,
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    launchUrl(Uri.parse("https://wa.me/201119723643"));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen.shade100,
                    padding: EdgeInsets.symmetric(
                      vertical: standardPadding * 0.8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: SvgPicture.asset("assets/icons/whatsapp.svg"),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
