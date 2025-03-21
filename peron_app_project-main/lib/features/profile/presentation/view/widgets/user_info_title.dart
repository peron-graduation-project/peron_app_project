import 'package:flutter/material.dart';

class UserInfoTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const UserInfoTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 5),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(255, 158, 156, 156)),
        ),
        child: Row(
          children: [
            Icon(icon, size: screenWidth * 0.06, color: Colors.black),
            SizedBox(width: screenWidth * 0.03),
            Text(
              text,
              style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}