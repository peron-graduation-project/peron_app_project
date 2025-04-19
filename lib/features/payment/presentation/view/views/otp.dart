import 'dart:async';
import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/payment/presentation/view/widgets/successDialogOTP.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  int seconds = 51;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        _timer?.cancel(); 
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          leading: CustomArrowBack(),
          title: Text(
            "كود التحقق",
            style: theme.headlineMedium!.copyWith(fontSize: 20),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(thickness: 1, indent: 8, endIndent: 8),
            SizedBox(height: 16),
            Text(
              "قم بإدخال رمز التحقق المُرسل إليك.",
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 20),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: screenWidth > 600 ? 80 : 60, 
                  height: screenWidth > 600 ? 80 : 60, 
                  child: TextField(
                    controller: controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                      ),
                      counterText: "",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "إعادة الارسال",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                SizedBox(width: screenWidth > 600 ? 250 : 180), 
                Text(
                  "00:${seconds.toString().padLeft(2, '0')}",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 32),
            SizedBox(
              width: screenWidth > 600 ? 400 : 330, 
              height: screenWidth > 600 ? 60 : 50, 
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: AppColors.primaryColor,
                ),
                onPressed: () {
                
                  showDialog(
                    context: context,
                    builder: (_) => SuccessDialogOTP(),
                  );
                },
                child: Text(
                  "تحقق",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
