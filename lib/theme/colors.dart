import 'package:flutter/material.dart';

class AppColors {
  static const tealPrimary = Color(0xFF00796B);
  static const tealLight = Color(0xFF00A28A);
  static const tealDark = Color(0xFF00665C);

  static const gradientTeal = LinearGradient(
    colors: [tealLight, tealPrimary, tealDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.6, 1.0],
  );

  // Center highlight: lighter teal in the middle, teal on the sides
  static const gradientTealCenter = LinearGradient(
    colors: [tealPrimary, tealLight, tealPrimary],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
