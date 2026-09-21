import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_spacing.dart';

class AppTheme {
  AppTheme._();

  /// Inter/Sora (the app's Latin display fonts) don't cover Bengali
  /// glyphs, so every text style falls back to a Bengali-capable font —
  /// applied once here rather than on each TextStyle, so it covers ad hoc
  /// `TextStyle(...)` literals across the app too (they inherit
  /// fontFamilyFallback from the ambient theme when they don't set their
  /// own).
  static final String _bengaliFallbackFont =
      GoogleFonts.notoSansBengali().fontFamily!;

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
      textTheme: GoogleFonts.interTextTheme().apply(
        fontFamilyFallback: [_bengaliFallbackFont],
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
