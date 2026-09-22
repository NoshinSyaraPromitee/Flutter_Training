import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFFF6DC),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.greenPrimary),
        textTheme: GoogleFonts.interTextTheme(),
        elevatedButtonTheme: _buttonTheme,
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF141F17),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.greenPrimary, brightness: Brightness.dark),
        textTheme: GoogleFonts.interTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
        elevatedButtonTheme: _buttonTheme,
      );

  static ElevatedButtonThemeData get _buttonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenPrimary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      );
}