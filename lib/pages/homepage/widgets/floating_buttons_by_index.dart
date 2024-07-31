import 'package:flutter/material.dart';

class FloatingButtonsByIndex extends StatelessWidget {
  const FloatingButtonsByIndex({
    super.key,
    required this.index,
    required this.id,
  });
  final int index;
  final String id;
  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => const SizedBox(),
      1 => const SizedBox(),
      2 => const SizedBox(),
      3 => const SizedBox(),
      4 => const SizedBox(),
      5 => const SizedBox(),
      6 => const SizedBox(),
      7 => const SizedBox(),
      _ => const SizedBox(),
    };
  }
}
