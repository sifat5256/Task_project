import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ─── Light Colors ───────────────────────────────────────
  static const _lightPrimary = Color(0xFF3B82F6);
  static const _lightSecondary = Color(0xFF8B5CF6);
  static const _lightAccent = Color(0xFF06B6D4);
  static const _lightBackground = Color(0xFFF8FAFC);
  static const _lightSurface = Color(0xFFFFFFFF);
  static const _lightError = Color(0xFFEF4444);
  static const _lightTextPrimary = Color(0xFF0F172A);
  static const _lightTextSecondary = Color(0xFF64748B);
  static const _lightBorder = Color(0xFFE2E8F0);

  // ─── Dark Colors ────────────────────────────────────────
  static const _darkPrimary = Color(0xFF3B82F6);
  static const _darkSecondary = Color(0xFF8B5CF6);
  static const _darkAccent = Color(0xFF22D3EE);
  static const _darkBackground = Color(0xFF0F172A);
  static const _darkSurface = Color(0xFF1E293B);
  static const _darkError = Color(0xFFF87171);
  static const _darkTextPrimary = Color(0xFFF1F5F9);
  static const _darkTextSecondary = Color(0xFF94A3B8);
  static const _darkBorder = Color(0xFF334155);

  // ─── Shared Constants ───────────────────────────────────
  static const double radiusSmall = 8;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;
  static const double radiusXL = 24;

  static BoxShadow get softShadow => BoxShadow(
        color: Colors.black.withValues(alpha: 0.06),
        blurRadius: 16,
        offset: const Offset(0, 4),
      );

  static BoxShadow get primaryGlow => BoxShadow(
        color: _lightPrimary.withValues(alpha: 0.3),
        blurRadius: 16,
        offset: const Offset(0, 4),
      );

  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [_lightPrimary, _lightSecondary],
      );

  // ─── Light Theme ────────────────────────────────────────
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: _lightBackground,
    colorScheme: const ColorScheme.light(
      primary: _lightPrimary,
      secondary: _lightSecondary,
      tertiary: _lightAccent,
      surface: _lightSurface,
      error: _lightError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _lightTextPrimary,
      onSurfaceVariant: _lightTextSecondary,
      outline: _lightBorder,
      surfaceContainerHighest: Color(0xFFE2E8F0),
    ),
    textTheme: _buildTextTheme(_lightTextPrimary, _lightTextSecondary),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: _lightSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLarge),
        side: const BorderSide(color: _lightBorder, width: 0.5),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: _lightBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: _lightBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: _lightPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: _lightError),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
        elevation: 0,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: _lightBorder,
      thickness: 0.5,
    ),
  );

  // ─── Dark Theme ─────────────────────────────────────────
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimary,
      secondary: _darkSecondary,
      tertiary: _darkAccent,
      surface: _darkSurface,
      error: _darkError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _darkTextPrimary,
      onSurfaceVariant: _darkTextSecondary,
      outline: _darkBorder,
      surfaceContainerHighest: Color(0xFF334155),
    ),
    textTheme: _buildTextTheme(_darkTextPrimary, _darkTextSecondary),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: _darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLarge),
        side: const BorderSide(color: _darkBorder, width: 0.5),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: _darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: _darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: _darkPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: _darkError),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
        elevation: 0,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: _darkBorder,
      thickness: 0.5,
    ),
  );

  // ─── Typography ─────────────────────────────────────────
  static TextTheme _buildTextTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primary,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondary,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondary,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondary,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondary,
      ),
    );
  }
}
