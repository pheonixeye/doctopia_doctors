import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  static const _loadingDuration = Duration(seconds: 4);
  static const _spinnerDuration = Duration(seconds: 1);
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _spinnerDuration,
    );
    _navigateToHomePage();
  }

  void _navigateToHomePage() async {
    await Future.delayed(_loadingDuration);
    if (mounted) {
      GoRouter.of(context).goNamed(RoutePage.homePage().name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Hero(
              tag: 'logo',
              child: Image.asset(AppAssets.logo),
            ),
            SpinKitPumpingHeart(
              color: const Color(0xffFE7800),
              size: 75.0,
              controller: _controller,
            ),
            const Gap(20),
            const Spacer(),
            const Text('version 0.0.1'),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}
