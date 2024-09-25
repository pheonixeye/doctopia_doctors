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
      _ => const SizedBox(),
    };
  }
}
