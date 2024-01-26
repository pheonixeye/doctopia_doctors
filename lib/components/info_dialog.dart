import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InformationDialog extends StatelessWidget {
  const InformationDialog({
    super.key,
    required this.title,
    required this.body,
  });
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Theme.of(context).colorScheme.tertiary,
      elevation: 10,
      title: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(body),
        ],
      ),
      actions: [
        FloatingActionButton.small(
          heroTag: 'confirm-dialog',
          onPressed: () {
            GoRouter.of(context).pop(true);
          },
          child: const Icon(Icons.check),
        ),
      ],
    );
  }
}
