import 'package:flutter/material.dart';

extension GapsExtensions on BuildContext {
  double get height {
    return MediaQuery.of(this).size.height;
  }

  double get width {
    return MediaQuery.of(this).size.width;
  }

  EdgeInsets get screenPadding {
    return const EdgeInsets.only(left: 16, right: 16, top: 40);
  }

  double dynamicHeight(double value) {
    return height * value;
  }

  double dynamicWidth(double value) {
    return width * value;
  }

  EdgeInsets get h10 {
    return const EdgeInsets.symmetric(horizontal: 10);
  }

  EdgeInsets get v10 {
    return const EdgeInsets.symmetric(vertical: 10);
  }

  EdgeInsets get h10v10 {
    return const EdgeInsets.symmetric(horizontal: 10, vertical: 10);
  }

  EdgeInsets get t10l10 {
    return const EdgeInsets.only(top: 10, left: 10);
  }

  EdgeInsets get t10r10 {
    return const EdgeInsets.only(top: 10, right: 10);
  }

  EdgeInsets get a10 {
    return const EdgeInsets.all(10);
  }

  EdgeInsets get a8 {
    return const EdgeInsets.all(8);
  }

  EdgeInsets get a16 {
    return const EdgeInsets.all(16);
  }

  EdgeInsets get l10r10 {
    return const EdgeInsets.only(top: 10, right: 10);
  }

  EdgeInsets get l16r16 {
    return const EdgeInsets.only(left: 16, right: 10);
  }
}
