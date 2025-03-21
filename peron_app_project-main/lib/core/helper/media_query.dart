import 'package:flutter/cupertino.dart';

class MediaQueryHelper {
  static late double screenWidth;
  static late double screenHeight;
  static late double devicePixelRatio;
  static late double statusBarHeight;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    devicePixelRatio = mediaQuery.devicePixelRatio;
    statusBarHeight = mediaQuery.padding.top;
  }
}
