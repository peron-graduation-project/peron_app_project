import 'package:flutter/material.dart';

class AboutItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AboutItem({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.012),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, 
            vertical: size.height * 0.018
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Icon(
                Icons.chevron_right, 
                color: Colors.grey, 
                size: isSmallScreen ? 18 : 22
              ),
            ],
          ),
        ),
      ),
    );
  }
}
