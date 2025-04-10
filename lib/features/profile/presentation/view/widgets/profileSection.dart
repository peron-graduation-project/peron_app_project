import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const ProfileSection({super.key, required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
          SizedBox(height: 8),
          Text(
            "تاليا أنس",
            style: theme.bodyMedium?.copyWith(color: Color(0xff282929))),
        ],
      ),
    );
  }
}