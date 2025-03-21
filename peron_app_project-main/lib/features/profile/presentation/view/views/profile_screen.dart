import 'package:flutter/material.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/change_password_dialog.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/user_info_title.dart';




class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الملف الشخصي",
          style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(right: screenWidth*0.03),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: screenWidth*0.045),
            onPressed: () {},
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(thickness: 1.5),
          SizedBox(height: screenHeight * 0.01),
          Center(
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
                        child: Icon(Icons.camera_alt_rounded, color: Colors.black, size: screenWidth * 0.05),
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
          ),
          SizedBox(height: screenHeight * 0.01),
          UserInfoTile(icon: Icons.person, text: "تاليا أنس"),
          UserInfoTile(icon: Icons.email_outlined, text: "talia155@gmail.com"),
          GestureDetector(
            onTap: () {
              showChangePasswordDialog(context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.011),
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
                      Icon(Icons.lock_outline, size: screenWidth * 0.05, color: Colors.black),
                      SizedBox(width: 10),
                      Text("تغيير كلمة المرور", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, size: screenWidth * 0.045, color: Colors.black),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}