import 'package:flutter/material.dart';

/// Tema dan palet warna aplikasi Jelajah Nusantara
/// (biru laut tua + oranye matahari terbenam).
class AppTheme {
   AppTheme._();

  static const Color dark = Color(0xFF0B3C49);
  static const Color accent = Color(0xFFFF8F3F);
  static const Color background = Color(0xFFF1FAF8);

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        primary: dark,
        secondary: accent,
        surface: background,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: dark,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: accent,
        unselectedItemColor: Colors.black45,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
