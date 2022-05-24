import 'package:flutter/material.dart';

class WidgetSpacer {
  static const baseSize = 5.0;

  static Widget vertical(double multiply) {
    return SizedBox(height: multiply * baseSize);
  }

  static Widget horizontal(double multiply) {
    return SizedBox(width: multiply * baseSize);
  }

  static double calc(double multiply) {
    return multiply * baseSize;
  }
}
