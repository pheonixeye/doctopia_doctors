import 'package:flutter/material.dart';

class SidebarXBtn extends StatelessWidget {
  const SidebarXBtn({
    super.key,
    required this.expanded,
    required this.onPressed,
    required this.icon,
    required this.labelOrTag,
    final bool? isDarkMode,
  }) : _isDarkMode = isDarkMode ?? false;
  final bool expanded;
  final void Function() onPressed;
  final Icon icon;
  final String labelOrTag;
  // ignore: unused_field
  final bool _isDarkMode;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
      child: expanded
          ? ElevatedButton.icon(
              onPressed: onPressed,
              icon: icon,
              label: Text(labelOrTag),
            )
          : FloatingActionButton.small(
              heroTag: labelOrTag,
              onPressed: onPressed,
              // backgroundColor: _isDarkMode ? Colors.grey : Colors.white,
              child: icon,
            ),
    );
  }
}
