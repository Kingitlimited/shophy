// lib/utils/themes/text_styles.dart
import 'package:flutter/material.dart';
import '../size_config.dart';

class TextStyles {
  // Display styles
  static TextStyle get displayLarge => TextStyle(
    fontSize: SizeConfig.getProportionateScreenWidth(32),
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static TextStyle get displayMedium => TextStyle(
    fontSize: SizeConfig.getProportionateScreenWidth(28),
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  // Headline styles
  static TextStyle get headlineMedium => TextStyle(
    fontSize: SizeConfig.getProportionateScreenWidth(24),
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // Title styles
  static TextStyle get titleLarge => TextStyle(
    fontSize: SizeConfig.getProportionateScreenWidth(20),
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // Body styles
  static TextStyle get bodyLarge => TextStyle(
    fontSize: SizeConfig.getProportionateScreenWidth(16),
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: SizeConfig.getProportionateScreenWidth(14),
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  // Label styles
  static TextStyle get labelLarge => TextStyle(
    fontSize: SizeConfig.getProportionateScreenWidth(16),
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static TextStyle get labelSmall => TextStyle(
    fontSize: SizeConfig.getProportionateScreenWidth(12),
    fontWeight: FontWeight.normal,
    height: 1.4,
  );
}