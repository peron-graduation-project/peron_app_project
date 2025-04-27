import 'package:flutter/material.dart';
import 'package:peron_project/features/payment/presentation/view/widgets/emptyscreen.dart';
import 'package:peron_project/features/payment/presentation/view/widgets/paymentMethodItem.dart';
import 'continuePayment.dart';
import 'creditcard.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _selectedPaymentMethod = 1;

  void _navigateToPayPalScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EmptyScreen()),
    );
  }

  void _navigateToVisaScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreditCardPaymentScreen()),
    );
  }

  void _navigateToVodafoneScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhoneVerificationScreen()),
    );
  }

  void _selectPaymentMethod(int index) {
    setState(() {
      _selectedPaymentMethod = index;
    });
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
          'طريقة الدفع',
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
      body: Column(
        children: [
          const Divider(height: 1, thickness: 0.7, color: Color(0xffbdbdbd)),
          Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: const Text(
                'اختر الطريقة التي تفضلها لإستكمال عملية الدفع',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          PaymentMethodItem(
            index: 0,
            selectedIndex: _selectedPaymentMethod,
            title: 'PayPal',
            icon: 'assets/images/paypal.png',
            isCustomIcon: true,
            onTap: () => _selectPaymentMethod(0),
          ),
          PaymentMethodItem(
            index: 1,
            selectedIndex: _selectedPaymentMethod,
            title: 'VISA',
            cardNumber: '•••• •••• •••• 5567',
            icon: 'assets/images/visa.png',
            isCustomIcon: true,
            onTap: () => _selectPaymentMethod(1),
          ),
          PaymentMethodItem(
            index: 2,
            selectedIndex: _selectedPaymentMethod,
            title: 'فودافون كاش',
            icon: 'assets/images/vodafon.png',
            isCustomIcon: true,
            onTap: () => _selectPaymentMethod(2),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                switch (_selectedPaymentMethod) {
                  case 0:
                    _navigateToPayPalScreen();
                    break;
                  case 1:
                    _navigateToVisaScreen();
                    break;
                  case 2:
                    _navigateToVodafoneScreen();
                    break;
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0F7757),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'استكمال',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Home indicator area
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
