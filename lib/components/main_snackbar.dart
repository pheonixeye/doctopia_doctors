import 'package:flutter/material.dart';

SnackBar iInfoSnackbar(String message, BuildContext context, [Color? color]) {
  return SnackBar(
    padding: const EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    behavior: SnackBarBehavior.fixed,
    duration: color == Colors.red
        ? const Duration(seconds: 15)
        : const Duration(seconds: 2),
    showCloseIcon: true,
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          SelectableText(message),
          const SizedBox(
            width: 20,
          ),
          Icon(
            Icons.info,
            color: color ?? Theme.of(context).primaryColor,
          ),
        ],
      ),
    ),
  );
}

void showInfoSnackbar(BuildContext context, String message, [Color? color]) {
  if (context.mounted) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
    ScaffoldMessenger.maybeOf(context)
        ?.showSnackBar(iInfoSnackbar(message, context, color));
  }
}
