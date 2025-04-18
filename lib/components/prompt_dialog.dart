import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPromptDialog extends StatelessWidget {
  const MainPromptDialog({
    super.key,
    required this.title,
    required this.body,
  });
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      alignment: Alignment.center,
      shadowColor: Theme.of(context).colorScheme.tertiary,
      elevation: 8,
      title: Text(title),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(body),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () {
              GoRouter.of(context).pop(false);
            },
            label: Text(context.loc.cancel),
            icon: const Icon(Icons.close),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor:
                  Theme.of(context).textTheme.headlineMedium?.color,
            ),
            onPressed: () {
              GoRouter.of(context).pop(true);
            },
            label: Text(context.loc.confirm),
            icon: const Icon(Icons.check),
          ),
        ),
      ],
    );
  }
}
