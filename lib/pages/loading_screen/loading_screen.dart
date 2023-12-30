import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Doctopia'),
            const CircularProgressIndicator(),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/homepage');
              },
              child: const Text('Go To HomePage'),
            ),
          ],
        ),
      ),
    );
  }
}
