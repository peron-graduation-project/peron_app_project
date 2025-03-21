import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const ProfileSection({required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: screenWidth * 0.15,
                backgroundImage: AssetImage("assets/images/talia.jpg"),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: CircleAvatar(
                  radius: screenWidth * 0.039,
                  backgroundColor: Color.fromARGB(255, 195, 193, 193),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.black,
                    size: screenWidth * 0.05,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          Text(
            "تاليا أنس",
            style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}