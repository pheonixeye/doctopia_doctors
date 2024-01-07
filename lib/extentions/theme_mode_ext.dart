import 'package:flutter/material.dart' show ThemeMode;

ThemeMode fromString(String value) {
  return switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}
