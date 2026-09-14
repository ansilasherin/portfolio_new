import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central theme mode controller for the application
class ThemeController {
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.dark);

  static bool get isDark => themeMode.value == ThemeMode.dark;

  static void toggleTheme() {
    themeMode.value =
        themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  static void setTheme(ThemeMode mode) {
    themeMode.value = mode;
  }
}

/// Dynamic color palette supporting both Dark and Light themes
class AppColors {
  // Context-aware color resolver
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color bg(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF0C0D10) : const Color(0xFFF8FAFC);

  static Color surface(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF13141A) : const Color(0xFFFFFFFF);

  static Color surface2(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF1A1C25) : const Color(0xFFF1F5F9);

  static Color border(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF22263A) : const Color(0xFFE2E8F0);

  static Color borderHover(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF333852) : const Color(0xFFCBD5E1);

  static Color accent(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF00D4B1) : const Color(0xFF00A88F);

  static Color accent2(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF6C63FF) : const Color(0xFF5A52E0);

  static Color text(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFFE8EAF0) : const Color(0xFF0F172A);

  static Color textMuted(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF7C8098) : const Color(0xFF475569);

  static Color textDim(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF4A4F6A) : const Color(0xFF94A3B8);

  static Color cardShadow(BuildContext context) => isDarkMode(context)
      ? Colors.black.withValues(alpha: 0.35)
      : const Color(0xFF64748B).withValues(alpha: 0.08);

  static const Color yellow = Color(0xFFF6C90E);
  static const Color red = Color(0xFFFF7676);
  static const Color green = Color(0xFF10B981);
}

/// ThemeData configurations for Material 3
class AppTheme {
  static final ValueNotifier<ThemeMode> themeNotifier = ThemeController.themeMode;

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0C0D10),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF13141A),
          primary: Color(0xFF00D4B1),
          secondary: Color(0xFF6C63FF),
          onSurface: Color(0xFFE8EAF0),
        ),
        dividerColor: const Color(0xFF22263A),
        textTheme: GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme),
      );

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: const ColorScheme.light(
          surface: Color(0xFFFFFFFF),
          primary: Color(0xFF00A88F),
          secondary: Color(0xFF5A52E0),
          onSurface: Color(0xFF0F172A),
        ),
        dividerColor: const Color(0xFFE2E8F0),
        textTheme: GoogleFonts.dmSansTextTheme(ThemeData.light().textTheme),
      );
}

/// Global typography styles adapting cleanly to context
class AppTextStyles {
  static TextStyle displayLarge(BuildContext context) => GoogleFonts.syne(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: AppColors.text(context),
        letterSpacing: -1.5,
        height: 1.05,
      );

  static TextStyle displayMedium(BuildContext context) => GoogleFonts.syne(
        fontSize: 40,
        fontWeight: FontWeight.w800,
        color: AppColors.text(context),
        letterSpacing: -1.0,
        height: 1.1,
      );

  static TextStyle headingLarge(BuildContext context) => GoogleFonts.syne(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.text(context),
        letterSpacing: -0.5,
        height: 1.15,
      );

  static TextStyle headingMedium(BuildContext context) => GoogleFonts.syne(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.text(context),
        letterSpacing: -0.3,
      );

  static TextStyle headingSmall(BuildContext context) => GoogleFonts.syne(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.text(context),
        letterSpacing: 0.2,
      );

  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted(context),
        height: 1.75,
      );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted(context),
        height: 1.7,
      );

  static TextStyle bodySmall(BuildContext context) => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted(context),
      );

  static TextStyle label(BuildContext context) => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.accent(context),
        letterSpacing: 1.5,
      );

  static TextStyle mono(BuildContext context) => GoogleFonts.dmMono(
        fontSize: 12,
        color: AppColors.textMuted(context),
      );

  static TextStyle navLink(BuildContext context) => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textMuted(context),
        letterSpacing: 1.2,
      );
}

/// Sizing and layout constants
class AppSizes {
  static const double maxWidth = 1140;
  static const double navHeight = 72;
  static const double sectionPadding = 96;
  static const double sectionPaddingMobile = 56;
}
