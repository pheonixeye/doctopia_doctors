import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:doctopia_doctors/routes/slide_transition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePage.loadingScreen().path,
      name: RoutePage.loadingScreen().name,
      builder: (context, state) {
        return RoutePage.loadingScreen().page;
      },
    ),
    GoRoute(
      path: RoutePage.homePage().path,
      name: RoutePage.homePage().name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          name: RoutePage.homePage().name,
          transitionsBuilder: (context, animation, secondary, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
          child: RoutePage.homePage().page,
        );
      },
      routes: [
        GoRoute(
          path: RoutePage.registerPageBasic().path,
          name: RoutePage.registerPageBasic().name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 500),
              name: RoutePage.registerPageBasic().name,
              transitionsBuilder: slideTransitionBuilder,
              child: RoutePage.registerPageBasic().page,
            );
          },
        ),
        GoRoute(
          path: RoutePage.loginPage().path,
          name: RoutePage.loginPage().name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 500),
              name: RoutePage.loginPage().name,
              transitionsBuilder: slideTransitionBuilder,
              child: RoutePage.loginPage().page,
            );
          },
        ),
      ],
    ),
  ],
);
