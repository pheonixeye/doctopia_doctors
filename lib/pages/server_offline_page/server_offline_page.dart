import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/providers/px_server_status.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ServerOfflinePage extends StatefulWidget {
  const ServerOfflinePage({super.key});

  @override
  State<ServerOfflinePage> createState() => _ServerOfflinePageState();
}

class _ServerOfflinePageState extends State<ServerOfflinePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  static const _spinnerDuration = Duration(seconds: 4);
  @override
  void initState() {
    super.initState();
    // print('loading screen initState');
    _controller = AnimationController(
      vsync: this,
      duration: _spinnerDuration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            Image.asset(Assets.icon),
            SpinKitPouringHourGlassRefined(
              color: const Color(0xffFE7800),
              size: 75.0,
              controller: _controller,
            ),
            const Gap(60),
            Consumer<PxServerStatus>(
              builder: (context, s, _) {
                while (s.message == null) {
                  return const SizedBox();
                }
                return Text(
                  s.message!,
                  textAlign: TextAlign.center,
                );
              },
            ),
            const Gap(20),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                if (mounted) {
                  GoRouter.of(context).goNamed(AppRouter.loadingscreen);
                }
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
            const Spacer(),
            const Text('version 0.0.1'),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}
