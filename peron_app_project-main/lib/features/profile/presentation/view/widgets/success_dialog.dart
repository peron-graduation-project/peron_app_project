import 'package:flutter/material.dart';

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),

                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xff0F7757),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(
                                255,
                                58,
                                56,
                                56,
                              ).withOpacity(0.05),
                              blurRadius: 25,
                              spreadRadius: 10,
                              offset: Offset(0, 8),
                            ),
                            BoxShadow(
                              color: Color.fromARGB(
                                255,
                                115,
                                110,
                                110,
                              ).withOpacity(0.08),
                              blurRadius: 20,
                              spreadRadius: 6,
                              offset: Offset(0, 4),
                            ),
                            BoxShadow(
                              color: Color.fromARGB(
                                255,
                                158,
                                156,
                                156,
                              ).withOpacity(0.12),
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
                            color: Color(0xff0F7757),
                            size: 28,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),
                      Text(
                        'تم تغيير كلمة المرور',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'تم تغيير كلمة المرور الخاصة بك بنجاح.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17, color: Colors.black54),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xff0F7757),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.white, size: 24),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
