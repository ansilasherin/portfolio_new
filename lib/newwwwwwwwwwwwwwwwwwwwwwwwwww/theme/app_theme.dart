import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bg = Color(0xFF0C0D10);
  static const surface = Color(0xFF13141A);
  static const surface2 = Color(0xFF1A1C25);
  static const border = Color(0xFF22263A);
  static const accent = Color(0xFF00D4B1);
  static const accent2 = Color(0xFF6C63FF);
  static const text = Color(0xFFE8EAF0);
  static const textMuted = Color(0xFF7C8098);
  static const textDim = Color(0xFF4A4F6A);
  static const yellow = Color(0xFFF6C90E);
  static const red = Color(0xFFFF7676);
}

class AppTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.surface,
          primary: AppColors.accent,
          secondary: AppColors.accent2,
        ),
        textTheme: GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme),
      );
}

class AppTextStyles {
  static TextStyle get displayLarge => GoogleFonts.syne(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: AppColors.text,
        letterSpacing: -1.5,
        height: 1.05,
      );

  static TextStyle get displayMedium => GoogleFonts.syne(
        fontSize: 40,
        fontWeight: FontWeight.w800,
        color: AppColors.text,
        letterSpacing: -1.0,
        height: 1.1,
      );

  static TextStyle get headingLarge => GoogleFonts.syne(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.text,
        letterSpacing: -0.5,
        height: 1.15,
      );

  static TextStyle get headingMedium => GoogleFonts.syne(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
        letterSpacing: -0.3,
      );

  static TextStyle get headingSmall => GoogleFonts.syne(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
        letterSpacing: 0.2,
      );

  static TextStyle get bodyLarge => GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.textMuted,
        height: 1.75,
      );

  static TextStyle get bodyMedium => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: AppColors.textMuted,
        height: 1.7,
      );

  static TextStyle get bodySmall => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
      );

  static TextStyle get label => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.accent,
        letterSpacing: 1.5,
      );

  static TextStyle get mono => GoogleFonts.dmMono(
        fontSize: 12,
        color: AppColors.textMuted,
      );

  static TextStyle get navLink => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
        letterSpacing: 1.2,
      );
}

class AppSizes {
  static const double maxWidth = 1100;
  static const double navHeight = 70;
  static const double sectionPadding = 96;
  static const double sectionPaddingMobile = 56;
}
