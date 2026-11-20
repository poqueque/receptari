import 'package:flutter/material.dart';

class AppStyles {
  static final Color primary = Colors.deepOrange.shade900;
  static final Color onPrimary = Colors.white;
  static final Color tagBackground = Colors.green.shade100;

  static final sectionTitle = TextStyle(fontSize: 20, fontWeight: .bold);
  static final mainTitle = TextStyle(
    fontSize: 28,
    fontWeight: .bold,
    color: Colors.white,
  );

  static final TextStyle cardTitle = TextStyle(fontSize: 16, fontWeight: .bold);
  static final TextStyle favoriteText = TextStyle(
    color: AppStyles.primary,
    fontSize: 20,
    fontWeight: .bold,
  );
  static final TextStyle smallWhiteText = TextStyle(
    fontSize: 14,
    color: onPrimary,
  );
  static final TextStyle mediumWhiteText = TextStyle(
    fontSize: 18,
    color: onPrimary,
  );
  static TextStyle statusText = TextStyle(fontSize: 14, color: onPrimary);

  static final Gradient imageShade = LinearGradient(
    begin: .topCenter,
    end: .bottomCenter,
    colors: [Colors.transparent, Colors.black54],
  );

  static final Widget tinySeparator = SizedBox(height: 4, width: 4);
  static final Widget smallSeparator = SizedBox(height: 8, width: 8);
  static final Widget mediumSeparator = SizedBox(height: 16, width: 16);
  static final Widget bigSeparator = SizedBox(height: 24, width: 24);
}
