import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final double screenWidth;

  const LogoutButton({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.logout, color: Colors.white, size: screenWidth * 0.05),
      label: Text(
        "تسجيل الخروج",
        style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: Color(0xff0F7757),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}