import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'theme',
          child: const Icon(Icons.theater_comedy),
          onPressed: () {
            context.read<PxTheme>().setThemeMode();
          },
        ),
        const Gap(10),
        FloatingActionButton(
          heroTag: 'language',
          child: const Icon(Icons.language),
          onPressed: () {
            context.read<PxLocale>().changeLocale();
          },
        ),
      ],
    );
  }
}
