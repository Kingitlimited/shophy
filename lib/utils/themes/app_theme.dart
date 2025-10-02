// lib/utils/themes/app_theme.dart
import 'package:flutter/material.dart';
import 'package:shophy/utils/size_config.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
        primary: Colors.blue,
        secondary: Colors.orange,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyles.displayLarge,
        displayMedium: TextStyles.displayMedium,
        headlineMedium: TextStyles.headlineMedium,
        titleLarge: TextStyles.titleLarge,
        bodyLarge: TextStyles.bodyLarge,
        bodyMedium: TextStyles.bodyMedium,
        labelLarge: TextStyles.labelLarge,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyles.titleLarge.copyWith(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.getProportionateScreenWidth(24),
            vertical: SizeConfig.getProportionateScreenHeight(16),
          ),
          textStyle: TextStyles.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getProportionateScreenWidth(16),
          vertical: SizeConfig.getProportionateScreenHeight(12),
        ),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyles.displayLarge.copyWith(color: Colors.white),
        displayMedium: TextStyles.displayMedium.copyWith(color: Colors.white),
        headlineMedium: TextStyles.headlineMedium.copyWith(color: Colors.white),
        titleLarge: TextStyles.titleLarge.copyWith(color: Colors.white),
        bodyLarge: TextStyles.bodyLarge.copyWith(color: Colors.white70),
        bodyMedium: TextStyles.bodyMedium.copyWith(color: Colors.white70),
        labelLarge: TextStyles.labelLarge.copyWith(color: Colors.white),
      ),
      useMaterial3: true,
    );
  }
}