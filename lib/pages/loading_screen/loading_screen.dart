import 'dart:async';

import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/pages/login_page/logic/login.dart';
import 'package:doctopia_doctors/providers/px_gov.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_server_status.dart';
import 'package:doctopia_doctors/providers/px_specialities.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:doctopia_doctors/services/local_database_service/local_database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  late final AnimationController _controller;
  static const _spinnerDuration = Duration(seconds: 1);
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(AppAssets.logo),
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
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    //TODO: check internet connection
    //check server state
    try {
      await Future.wait([
        context.read<PxServerStatus>().checkServerStatus(),
        context.read<PxSpeciality>().fetchSpecialities(),
        context.read<PxGov>().loadGovernorates(),
      ]);
    } catch (e) {
      if (mounted) {
        await GoRouter.of(context)
            .pushReplacementNamed(RoutePage.serverOfflinePage().name);
      }
      print(e.toString());
    }
    if (mounted) {
      await Future.wait([
        context.read<PxLocalDatabase>().fetchLanguageFromDb(),
        context.read<PxLocalDatabase>().fetchThemeFromDb(),
        context.read<PxLocalDatabase>().fetchDocIdFromDb(),
      ]).whenComplete(() async {
        await Future.wait([
          context.read<PxLocale>().setLocaleFromLocalDb(),
          context.read<PxTheme>().setThemeModeFromDb(),
          //* check if local storage has a doctor model then login
          (context.read<PxLocalDatabase>().password != null &&
                  context.read<PxLocalDatabase>().syndId != null)
              ? loginLogic(
                  context: context,
                  synd_id: context.read<PxLocalDatabase>().syndId!,
                  password: context.read<PxLocalDatabase>().password!,
                )
              : Future.delayed(const Duration(milliseconds: 1)),
        ]);
      }).whenComplete(() async {
        await GoRouter.of(context)
            .pushReplacementNamed(RoutePage.homePage().name);
      });
    }
  }
}
