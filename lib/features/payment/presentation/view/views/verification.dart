import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peron_project/features/myAds/presentation/view/widgets/successDialog.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );
  int _remainingSeconds = 59;
  Timer? _timer;
  bool _isVerifyEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();

    for (var controller in _controllers) {
      controller.addListener(_checkAllFieldsFilled);
    }

    for (int i = 0; i < 4; i++) {
      _focusNodes[i].addListener(() {
        setState(() {});
      });
    }
  }

  void _checkAllFieldsFilled() {
    bool allFilled = true;
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        allFilled = false;
        break;
      }
    }

    setState(() {
      _isVerifyEnabled = allFilled;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _resendCode() {
    setState(() {
      _remainingSeconds = 59;
    });
    _startTimer();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
  }

  void _showSuccessDialog() {
    SuccessDialog.show(
      context: context,
      message: 'تم الدفع ونشر العقار بنجاح',
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'كود التحقق',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios,
                color: Colors.black, size: 18),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        leading: const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(height: 1, color: Colors.grey[200]),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'قم بإدخال رمز التحقق المرسل إليك',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: 70,
                  height: 60,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF0F7757),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) => _onChanged(value, index),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_remainingSeconds.toString().padLeft(2, '0')}:00',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                GestureDetector(
                  onTap: _remainingSeconds == 0 ? _resendCode : null,
                  child: Text(
                    'إعادة الإرسال',
                    style: TextStyle(
                      fontSize: 14,
                      color: _remainingSeconds == 0
                          ? const Color(0xFF0F7757)
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: _isVerifyEnabled ? () => _showSuccessDialog() : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F7757),
                disabledBackgroundColor: Colors.grey[300],
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'تحقق',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
