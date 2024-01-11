import 'package:flutter/material.dart';

typedef GlobalTransitionBuilder = Widget Function(
    BuildContext, Animation<double>, Animation<double>, Widget);

Widget slideTransitionBuilder(
  BuildContext context,
  Animation<double> a1,
  Animation<double> a2,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(a1),
    child: child,
  );
}

Widget fadeTransitionBuilder(
  BuildContext context,
  Animation<double> a1,
  Animation<double> a2,
  Widget child,
) {
  return FadeTransition(
    opacity: CurveTween(curve: Curves.easeIn).animate(a1),
    child: child,
  );
}
