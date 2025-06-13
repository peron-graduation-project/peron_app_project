import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';

class CreditDetails extends StatelessWidget {
  const CreditDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFE881A6), Color(0xFF9E77ED)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          // Bank Name
          Positioned(
            top: 12,
            left: 12,
            child: Text(
              'BANK NAME',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.primaryFontFamily,
              ),
            ),
          ),
          // Visa Logo
          Positioned(
            top: 11,
            right: 17,
            child: Text(
              'VISA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: Fonts.primaryFontFamily,
              ),
            ),
          ),

          Positioned(
              top: 70,
              left: 10,
              child: Image.asset("assets/images/Chip+wireless.png")),

          // Card Number
          Positioned(
            top: 140,
            left: 20,
            child: Text(
              '1234 5678 9009 8765',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 2,
                fontFamily: Fonts.primaryFontFamily,
              ),
            ),
          ),
          // Cardholder Name and Expiry
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: [
                Text(
                  '02/28',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: Fonts.primaryFontFamily,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  'CARDHOLDER NAME',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: Fonts.primaryFontFamily,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}