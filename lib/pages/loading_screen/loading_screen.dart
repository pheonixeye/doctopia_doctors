import 'dart:async';

import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/providers/px_gov.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_server_status.dart';
import 'package:doctopia_doctors/providers/px_specialities.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:doctopia_doctors/services/local_database_service/local_database_service.dart';
import 'package:flutter/foundation.dart';
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
              Image.asset(
                Assets.icon,
                width: 100,
                height: 100,
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
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    //deferred: check internet connection
    //check server state
    try {
      await Future.wait([
        context.read<PxServerStatus>().checkServerStatus(),
        context.read<PxSpeciality>().fetchSpecialities(),
        context.read<PxGov>().loadGovernorates(),
      ]);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      if (context.mounted) {
        await GoRouter.of(context).pushNamed(AppRouter.offline);
      }
    }
    if (context.mounted) {
      await context.read<PxLocalDatabase>().initDb().whenComplete(() {
        context.read<PxLocalDatabase>().fetchLanguageFromDb();
        context.read<PxLocalDatabase>().fetchThemeFromDb();
        context.read<PxLocale>().setLocaleFromLocalDb();
        context.read<PxTheme>().setThemeModeFromDb();
        final _u = context.read<PxUserModel>();
        if (_u.isLoggedIn) {
          GoRouter.of(context).pushNamed(
            AppRouter.home,
            pathParameters: {
              "id": _u.id!,
            },
          );
        } else {
          GoRouter.of(context).pushNamed(AppRouter.login);
        }
      });
    }
  }
}
