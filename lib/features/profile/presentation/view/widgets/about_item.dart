import 'package:flutter/material.dart';

class AboutItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AboutItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
                  Text(title, style: theme.labelLarge?.copyWith(color:Color(0xff282929) )),
                ],
              ),
             Icon(Icons.arrow_forward_ios, size: screenWidth * 0.045, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
