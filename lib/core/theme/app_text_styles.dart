import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Text styles extracted from the MyPlantPal Figma design.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle heroTitle = GoogleFonts.shadowsIntoLight(
    fontSize: 60,
    color: AppColors.brownHeading,
    letterSpacing: 0.4,
  );

  static TextStyle screenTitle = GoogleFonts.shadowsIntoLight(
    fontSize: 36,
    color: AppColors.brownHeading,
    letterSpacing: 0.4,
  );

  static TextStyle loadingCaption = GoogleFonts.inter(
    fontSize: 12,
    color: AppColors.orangeAccent,
  );

  static TextStyle chatLabel = GoogleFonts.inter(
    fontSize: 11,
    color: AppColors.greenPrimary,
  );

  static TextStyle bodyText = GoogleFonts.inter(
    fontSize: 13,
    height: 1.5,
    color: AppColors.textDark,
  );
}
