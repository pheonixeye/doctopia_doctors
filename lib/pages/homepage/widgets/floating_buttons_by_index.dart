import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FloatingButtonsByIndex extends StatelessWidget {
  const FloatingButtonsByIndex({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => const SizedBox(),
      1 => const SizedBox(),
      2 => const SizedBox(),
      3 => const SizedBox(),
      4 => FloatingActionButton.extended(
          heroTag: 'create-clinic',
          onPressed: () {
            GoRouter.of(context).goNamed(RoutePage.createClinicPage().name);
          },
          label: const Text('Create Clinic'),
          icon: const Icon(Icons.add),
        ),
      5 => const SizedBox(),
      6 => const SizedBox(),
      7 => const SizedBox(),
      _ => const SizedBox(),
    };
  }
}
