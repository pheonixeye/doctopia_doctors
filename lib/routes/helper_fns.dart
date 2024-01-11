import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:doctopia_doctors/routes/transitions.dart';
import 'package:go_router/go_router.dart';

GoRoute goRouteFromRoutePage(RoutePage model,
    [GlobalTransitionBuilder transitionBuilder = slideTransitionBuilder]) {
  return GoRoute(
    path: model.path,
    name: model.name,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 500),
        name: model.name,
        transitionsBuilder: transitionBuilder,
        child: model.page,
      );
    },
  );
}
