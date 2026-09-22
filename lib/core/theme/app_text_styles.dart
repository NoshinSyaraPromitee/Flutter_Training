import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get heroTitle => GoogleFonts.fredoka(
        fontSize: 60,
        fontWeight: FontWeight.w600,
        color: AppColors.brownHeading,
        letterSpacing: 0.2,
      );

  static TextStyle get screenTitle => GoogleFonts.fredoka(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: AppColors.brownHeading,
        letterSpacing: 0.2,
      );

  static TextStyle get loadingCaption => GoogleFonts.inter(
        fontSize: 12,
        color: AppColors.orangeAccent,
      );

  static TextStyle get chatLabel => GoogleFonts.inter(
        fontSize: 11,
        color: AppColors.greenPrimary,
      );

  static TextStyle get bodyText => GoogleFonts.inter(
        fontSize: 13,
        height: 1.5,
        color: AppColors.textDark,
      );

  static TextStyle inter(double size, {FontWeight w = FontWeight.w500, Color? c, double? h}) =>
      GoogleFonts.inter(fontSize: size, fontWeight: w, color: c ?? AppColors.textDark, height: h);
}