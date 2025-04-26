import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peron_project/features/payment/presentation/view/views/verification.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'استكمال الدفع',
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
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 1, color: Colors.grey[200]),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Text(
                  'قم بإدخال رقم الهاتف لاستكمال عملية الدفع وسيتم إرسال رمز الـ OTP الخاص بك للاستكمال',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.4,
                  ),
                ),
              ),

              // عنوان حقل الهاتف بنفس المكان في الصورة
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  'الهاتف',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                            hintText: '',
                          ),
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 25,
                        color: Colors.grey[300],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Row(
                          children: [
                            const Text(
                              '(+20)',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.keyboard_arrow_down,
                                size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 6),
                            Container(
                              width: 24,
                              height: 16,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey[300]!, width: 0.5),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Column(
                                children: [
                                  Expanded(child: Container(color: Colors.red)),
                                  Expanded(
                                      child: Container(color: Colors.white)),
                                  Expanded(
                                      child: Container(color: Colors.black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerificationCodeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B7F5F),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "استكمال",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // المساحة المتبقية
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
