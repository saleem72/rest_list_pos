//

import 'package:flutter/material.dart';

class Pallet {
  Pallet._();

  static const primary = Color(0xFFE7A968);

  static final primarySwatch = primary.toMaterialColor();
  static const background = Color(0xFFEFEFEF);
  static const darkAppBar = Color(0xFF02030A);
  static const meduimDarkText = Color(0xFF5D5D5D);
  static const cardColors = Color(0xFFF2F2F2);
  static const red = Color(0xFFFF5F57);
  static const grey = Color(0xFF8F8F8F);
  static const green = Color(0xFF009964);
  static const secondBackground = Color(0xFFF5F5F5);
  static const borders = Color(0xFF707070);
  static const textGrey = Color(0xFF8F8F8F);
  static const cyan = Color(0xFF00B4CB);
}

extension _Material on Color {
  Map<int, Color> _toSwatch() => {
        50: withOpacity(0.1),
        100: withOpacity(0.2),
        200: withOpacity(0.3),
        300: withOpacity(0.4),
        400: withOpacity(0.5),
        500: withOpacity(0.6),
        600: withOpacity(0.7),
        700: withOpacity(0.8),
        800: withOpacity(0.9),
        900: this,
      };

  MaterialColor toMaterialColor() => MaterialColor(
        value,
        _toSwatch(),
      );

  // MaterialAccentColor toMaterialAccentColor() => MaterialAccentColor(
  //       value,
  //       _toSwatch(),
  //     );
}
