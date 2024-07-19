import 'package:flutter/material.dart';

class PxOverlay extends ChangeNotifier {
  // OverlayEntry? _overlayEntry;
  // OverlayEntry? get overlayEntry => _overlayEntry;

  final Map<String, OverlayEntry> _overlays = {};
  Map<String, OverlayEntry> get overlays => _overlays;

  // bool get isOverlayShown => (_overlayEntry != null && _overlayEntry!.mounted);

  void toggleOverlay({
    required String id,
    required Widget child,
    required BuildContext context,
  }) {
    _overlays[id] != null
        ? removeOverlay(id)
        : _insertOverlay(
            id: id,
            child: child,
            context: context,
          );
  }

  void removeOverlay(String id) {
    // _overlayEntry?.remove();
    // _overlayEntry = null;
    _overlays[id]?.remove();
    _overlays.remove(id);
  }

  void _insertOverlay({
    required String id,
    required Widget child,
    required BuildContext context,
  }) {
    _overlays[id] = OverlayEntry(
      builder: (context) {
        return child;
      },
    );

    Overlay.of(context).insert(_overlays[id]!);
  }
}
