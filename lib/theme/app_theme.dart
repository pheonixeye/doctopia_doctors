import 'package:flutter/material.dart';

class AppTheme {
  static CardTheme cardTheme = CardTheme(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  static ThemeData theme({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required Iterable<ThemeExtension<dynamic>>? extensions,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      extensions: extensions,
      textTheme: textTheme,
      cardTheme: cardTheme,
    );
  }
}
