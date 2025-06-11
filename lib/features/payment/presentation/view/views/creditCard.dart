import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';
// import 'package:peron_project/features/myAds/presentation/view/widgets/successDialog.dart';
import 'package:peron_project/features/payment/presentation/view/widgets/creditdetails.dart';
import 'package:peron_project/features/payment/presentation/view/widgets/customField.dart';
import 'package:peron_project/features/payment/presentation/view/widgets/successPaymentDialog.dart';


class CreditCardPaymentScreen extends StatefulWidget {
  const CreditCardPaymentScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardPaymentScreen> createState() =>
      _CreditCardPaymentScreenState();
}

class _CreditCardPaymentScreenState extends State<CreditCardPaymentScreen> {
  final TextEditingController _cardholderNameController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardholderNameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    final double horizontalPadding = screenWidth * 0.05;
    final double verticalSpacing = screenHeight * 0.02;

    final double titleFontSize = screenWidth * 0.045;
    final double labelFontSize = screenWidth * 0.04;
    final double buttonFontSize = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black, 
            size: 18
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [],
        title: Text(
          'اضافة بطاقة',
          style: TextStyle(
            color: Colors.black,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            fontFamily: Fonts.primaryFontFamily,
          ),
        ),
        
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(height: 1, color: Colors.grey[200]),
                    SizedBox(height: verticalSpacing),

                    SizedBox(
                      height: screenHeight * 0.25, 
                      child: CreditDetails(),
                    ),

                    SizedBox(height: verticalSpacing),

                    // Card Details Text
                    Text(
                      'بيانات البطاقة',
                      style: TextStyle(
                        fontSize: labelFontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(137, 0, 0, 0),
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                    ),

                    SizedBox(height: verticalSpacing * 0.75),

                    // Cardholder Name Field
                    CustomField(
                      controller: _cardholderNameController,
                      labelText: 'اسم صاحب البطاقة',
                    ),

                    SizedBox(height: verticalSpacing * 0.75),

                    // Card Number Field
                    CustomField(
                      controller: _cardNumberController,
                      labelText: 'رقم البطاقة',
                      isNumeric: true,
                      maxLength: 16,
                    ),

                    SizedBox(height: verticalSpacing * 0.75),

                    // Expiry Date and CVV Fields
                    Row(
                      children: [
                        Expanded(
                          child: CustomField(
                            controller: _expiryDateController,
                            labelText: 'رقم الصلاحية',
                            isNumeric: true,
                            maxLength: 4,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        Expanded(
                          child: CustomField(
                            controller: _cvvController,
                            labelText: 'CVV',
                            isNumeric: true,
                            maxLength: 3,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: verticalSpacing * 1.5),

                    // Pay Button
                    SizedBox(
                      height: screenHeight * 0.065, 
                      child: ElevatedButton(
                        onPressed: () {
                          SuccessPaymentDialog.show(
                            context: context,
                            message: 'تم الدفع ونشر العقار بنجاح',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0F7757),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ' دفع',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: buttonFontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.primaryFontFamily,
                                  ),
                                ),
                                Text(
                                  ' 00.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: buttonFontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.primaryFontFamily,
                                  ),
                                ),
                                Text(
                                  '239 ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: buttonFontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.primaryFontFamily,
                                  ),
                                ),
                                Text(
                                  'جنيه ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: buttonFontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.primaryFontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: verticalSpacing),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}