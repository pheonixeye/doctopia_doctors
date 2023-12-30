import 'package:doctopia_doctors/pages/homepage/homepage.dart';
import 'package:doctopia_doctors/pages/loading_screen/loading_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: "loading_screen",
      builder: (context, state) {
        return const LoadingScreen();
      },
    ),
    GoRoute(
      path: '/homepage',
      name: "homepage",
      builder: (context, state) {
        return const HomePage();
      },
    ),
  ],
);
