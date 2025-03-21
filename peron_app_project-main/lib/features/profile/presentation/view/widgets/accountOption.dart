import 'package:flutter/material.dart';

class AccountOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final double screenWidth;
  final  VoidCallback? onTap;

  const AccountOption({required this.icon, required this.title, required this.screenWidth, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.038),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromARGB(255, 158, 156, 156)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: screenWidth * 0.06, color: Colors.black),
                  SizedBox(width: 10),
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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