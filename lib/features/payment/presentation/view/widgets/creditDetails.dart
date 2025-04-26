import 'package:flutter/material.dart';

class CreditDetails extends StatelessWidget {
  const CreditDetails({Key? key}) : super(key: key);

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
          const Positioned(
            top: 12,
            left: 12,
            child: Text(
              'BANK NAME',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Visa Logo
          const Positioned(
            top: 11,
            right: 17,
            child: Text(
              'VISA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          Positioned(
              top: 70,
              left: 10,
              child: Image.asset("assets/images/Chip+wireless.png")),

          // Card Number
          const Positioned(
            top: 140,
            left: 20,
            child: Text(
              '1234 5678 9009 8765',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
          ),
          // Cardholder Name and Expiry
          const Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: [
                Text(
                  '02/28',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
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
