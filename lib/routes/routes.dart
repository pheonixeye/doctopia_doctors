import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePage.loadingScreen().path,
      name: RoutePage.loadingScreen().name,
      builder: (context, state) {
        return RoutePage.loadingScreen(
          key: state.pageKey,
        ).page;
      },
      routes: [
        GoRoute(
          path: RoutePage.registerPageBasic().path,
          name: RoutePage.registerPageBasic().name,
          builder: (context, state) {
            return RoutePage.registerPageBasic(
              key: state.pageKey,
            ).page;
          },
        ),
        GoRoute(
          path: RoutePage.loginPage().path,
          name: RoutePage.loginPage().name,
          builder: (context, state) {
            return RoutePage.loginPage(
              key: state.pageKey,
            ).page;
          },
        ),
        GoRoute(
          path: RoutePage.homePage().path,
          name: RoutePage.homePage().name,
          builder: (context, state) {
            return RoutePage.homePage(
              key: state.pageKey,
            ).page;
          },
        ),
      ],
    ),
  ],
);
