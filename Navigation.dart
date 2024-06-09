import 'package:flutter/material.dart';

class Navigation {
  static void replaceScreen(BuildContext context, Widget newScreen) {
    removeScreen(context);
    showScreen(context, newScreen);
  }

  static void removeScreen(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static void showScreen(BuildContext context, Widget newScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => newScreen),
    );
  }
}