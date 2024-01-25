import 'package:doctopia_doctors/routes/helper_fns.dart';
import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:doctopia_doctors/routes/transitions.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    goRouteFromRoutePage(RoutePage.loadingScreen()),
    goRouteFromRoutePage(RoutePage.serverOfflinePage()),
    GoRoute(
      path: RoutePage.homePage().path,
      name: RoutePage.homePage().name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          name: RoutePage.homePage().name,
          transitionsBuilder: fadeTransitionBuilder,
          child: RoutePage.homePage().page,
        );
      },
      routes: [
        goRouteFromRoutePage(RoutePage.registerPageBasic()),
        goRouteFromRoutePage(RoutePage.registerPagePassword()),
        goRouteFromRoutePage(RoutePage.loginPage()),
        goRouteFromRoutePage(RoutePage.tokenValidationPage()),
        goRouteFromRoutePage(RoutePage.createClinicPage()),
        goRouteFromRoutePage(RoutePage.clinicSchedulePage()),
      ],
    ),
  ],
);
