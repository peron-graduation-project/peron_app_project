import 'package:flutter/material.dart';

class AccountOption extends StatelessWidget {
  final IconData? icon;
  final String title;
  final double screenWidth;
  final  VoidCallback? onTap;
  final Color? iconColor;
  final Color? textColor;
  final bool? showArrow;


  const AccountOption({super.key,  this.icon, required this.title, required this.screenWidth,  this.onTap, this.iconColor=Colors.black, this.textColor, this.showArrow=true});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.038),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xffDADADA)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: screenWidth * 0.06, color:iconColor),
                  SizedBox(width: 10),
                  Text(title, style: theme.labelLarge?.copyWith(color:textColor??Color(0xff282929) )),
                ],
              ),
           showArrow!?Icon(Icons.arrow_forward_ios, size: screenWidth * 0.045, color: Colors.black):Container(),
            ],
          ),
        ),
      ),
    );
  }
}