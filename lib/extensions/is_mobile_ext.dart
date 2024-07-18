import 'package:flutter/material.dart';

extension IsMobile on BuildContext {
  bool get isMobile {
    final double width = MediaQuery.sizeOf(this).width;
    if (width < 600) {
      return true;
    }
    return false;
  }
}
