// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/providers/px_clinic_images.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ImageViewerDialog extends StatefulWidget {
  const ImageViewerDialog({
    super.key,
    required this.image,
    required this.id,
    required this.clinic_id,
  });
  final Image image;
  final String id;
  final String clinic_id;

  @override
  State<ImageViewerDialog> createState() => _ImageViewerDialogState();
}

class _ImageViewerDialogState extends State<ImageViewerDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Theme.of(context).colorScheme.tertiary,
      elevation: 10,
      title: Row(
        children: [
          const Spacer(),
          FloatingActionButton.small(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            heroTag: 'close-dialog',
            onPressed: () {
              GoRouter.of(context).pop(false);
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: widget.id,
            child: widget.image,
          ),
          FloatingActionButton.small(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              await shellFunction(
                context,
                toExecute: () async {
                  await context.read<PxClinicImages>().deleteClinicImage(
                        widget.id,
                        widget.clinic_id,
                      );
                  if (mounted) {
                    GoRouter.of(context).pop<bool>(true);
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
