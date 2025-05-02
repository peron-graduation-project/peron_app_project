import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/advertisements/presentation/views/add_property_screen.dart';

class NoPublishedAdsContent extends StatelessWidget {
  final VoidCallback onAddProperty;

  const NoPublishedAdsContent({Key? key, required this.onAddProperty})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * 0.05),
              Image.asset(
                'assets/images/noAdv.png',
                width: 160,
                height: 160,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 25),
              Text(
                'لا يوجد إعلانات منشوره بعد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 15, 15, 15),
                  fontFamily: Fonts.primaryFontFamily,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'بعد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: Fonts.primaryFontFamily,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'أضف إعلانات لتصل إلى الاف المستخدمين',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: Fonts.primaryFontFamily,
                  fontWeight: FontWeight.w200,
                  color: const Color.fromARGB(255, 154, 153, 153),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPropertyScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F8E65),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'اضف عقار',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: Fonts.primaryFontFamily,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
