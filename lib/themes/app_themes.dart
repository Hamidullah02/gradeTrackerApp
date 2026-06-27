import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const _primary = Color(0xFF1A237E);
  static const _primaryDark = Color(0xFF0D47A1);

  static final lightTheme = _theme(
    brightness: Brightness.light,
    primary: _primary,
    scaffold: Colors.grey.shade50,
    card: Colors.white,
    input: Colors.white,
    border: Colors.grey.shade300,
    focus: _primary,
    text: Colors.black87,
    subtext: Colors.black54,
    divider: Colors.grey.shade300,
    secondary: const Color(0xFF0D47A1),
  );

  static final darkTheme = _theme(
    brightness: Brightness.dark,
    primary: _primaryDark,
    scaffold: const Color(0xFF121212),
    card: const Color(0xFF1E1E1E),
    input: const Color(0xFF2C2C2C),
    border: Colors.grey.shade800,
    focus: const Color(0xFF42A5F5),
    text: Colors.white,
    subtext: Colors.white60,
    divider: Colors.grey.shade800,
    secondary: const Color(0xFF42A5F5),
  );

  static ThemeData _theme({
    required Brightness brightness,
    required Color primary,
    required Color scaffold,
    required Color card,
    required Color input,
    required Color border,
    required Color focus,
    required Color text,
    required Color subtext,
    required Color divider,
    required Color secondary,
  }) {
    return ThemeData(
      brightness: brightness,
      primaryColor: primary,
      scaffoldBackgroundColor: scaffold,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: card,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: input,
        border: _inputBorder(border),
        enabledBorder: _inputBorder(border),
        focusedBorder: _inputBorder(focus, width: 2),
        errorBorder: _inputBorder(Colors.red),
        focusedErrorBorder: _inputBorder(Colors.red, width: 2),
        labelStyle: TextStyle(color: border.withOpacity(0.6)),
        hintStyle: TextStyle(color: border.withOpacity(0.4)),
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(color: primary, fontWeight: FontWeight.bold, fontSize: 20),
        titleLarge: TextStyle(color: text, fontWeight: FontWeight.w600, fontSize: 18),
        bodyLarge: TextStyle(color: text, fontSize: 16),
        bodyMedium: TextStyle(color: subtext, fontSize: 14),
      ),
      colorScheme: brightness == Brightness.light
          ? const ColorScheme.light(primary: Color(0xFF1A237E), secondary: Color(0xFF0D47A1))
          : const ColorScheme.dark(primary: Color(0xFF0D47A1), secondary: Color(0xFF42A5F5)),
      dividerTheme: DividerThemeData(color: divider, thickness: 1),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static Color getGradeColor(String grade) {
    switch (grade) {
      case 'A': return Colors.green;
      case 'B': return Colors.blue;
      case 'C': return Colors.orange;
      case 'F': return Colors.red;
      default: return Colors.grey;
    }
  }

  static Color getGradeBackgroundColor(String grade) => getGradeColor(grade).withOpacity(0.2);
}