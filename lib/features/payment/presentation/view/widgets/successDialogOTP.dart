import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

class SuccessDialogOTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            SizedBox(
              width: screenWidth * 0.9, 
              
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 58, 56, 56).withOpacity(0.05),
                            blurRadius: 25,
                            spreadRadius: 10,
                            offset: Offset(0, 8),
                          ),
                          BoxShadow(
                            color: Color.fromARGB(255, 115, 110, 110).withOpacity(0.08),
                            blurRadius: 20,
                            spreadRadius: 6,
                            offset: Offset(0, 4),
                          ),
                          BoxShadow(
                            color: Color.fromARGB(255, 158, 156, 156).withOpacity(0.12),
                            blurRadius: 15,
                            spreadRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: AppColors.primaryColor,
                          size: screenWidth > 600 ? 40 : 28, 
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "تم الدفع ونشر العقار بنجاح",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: screenWidth > 600 ? 20 : 16, 
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: screenWidth > 600 ? 200 : 160, 
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "عوده",
                          style: TextStyle(color: Colors.white, fontSize: screenWidth > 600 ? 18 : 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
