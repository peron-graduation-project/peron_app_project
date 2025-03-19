import 'package:flutter/material.dart';
import 'success_dialog.dart';

void showChangePasswordDialog(BuildContext context) {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      double screenWidth = MediaQuery.of(context).size.width;
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              width: screenWidth * 0.9,
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.015),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff0F7757),
                        ),
                        child: Icon(
                          Icons.close,
                          size: screenWidth * 0.05,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    'إنشاء كلمة مرور جديدة',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.03),
                  buildPasswordField(
                    "كلمة المرور الحالية",
                    currentPasswordController,
                    obscureText1,
                    () {
                      setState(() {
                        obscureText1 = !obscureText1;
                      });
                    },
                    context,
                  ),
                  buildPasswordField(
                    "كلمة المرور الجديدة",
                    newPasswordController,
                    obscureText2,
                    () {
                      setState(() {
                        obscureText2 = !obscureText2;
                      });
                    },
                    context,
                  ),
                  buildPasswordField(
                    "تأكيد كلمة المرور الجديدة",
                    confirmPasswordController,
                    obscureText3,
                    () {
                      setState(() {
                        obscureText3 = !obscureText3;
                      });
                    },
                    context,
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  SizedBox(
                    height: screenWidth * 0.12,
                    width: screenWidth * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showSuccessDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0F7757),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'تأكيد',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget buildPasswordField(
  String hint,
  TextEditingController controller,
  bool obscureText,
  VoidCallback toggleVisibility,
  BuildContext context,
) {
  double screenWidth = MediaQuery.of(context).size.width;

  return Container(
    margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 158, 156, 156)),
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.black54),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: screenWidth * 0.045,
          color: Colors.black54,
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.black54,
          size: screenWidth * 0.06,
        ),
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.black54,
          ),
          onPressed: toggleVisibility,
        ),
      ),
    ),
  );
}
