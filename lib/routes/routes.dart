// ignore_for_file: constant_identifier_names

import 'package:doctopia_doctors/pages/clinic_schedule_page/clinic_schedule_page.dart';
import 'package:doctopia_doctors/pages/create_clinic_page/create_clinic_page.dart';
import 'package:doctopia_doctors/pages/homepage/homepage.dart';
import 'package:doctopia_doctors/pages/loading_screen/loading_screen.dart';
import 'package:doctopia_doctors/pages/login_page/login_page.dart';
import 'package:doctopia_doctors/pages/register_page_basic/register_page_basic.dart';
import 'package:doctopia_doctors/pages/server_offline_page/server_offline_page.dart';
import 'package:doctopia_doctors/pages/token_validation_page/token_validation_page.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
// import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:doctopia_doctors/routes/transitions.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static const String loadingscreen = '/';
  static const String home = 'home';
  static const String login = 'login';
  static const String register = 'register';
  static const String createclinic = 'createclinic';
  static const String clinicsch = 'clinicsch';
  static const String offline = 'offline';
  static const String forgotpassword = 'forgotpassword';
  static const String tokenvalidation = 'tokenvalidation';

  static final GoRouter router = GoRouter(
    initialLocation: loadingscreen,
    redirect: (context, state) {
      if (context.read<PxUserModel>().id == null) {
        return "/$login";
      }
      return null;
    },
    routes: [
      GoRoute(
        path: loadingscreen,
        name: loadingscreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 500),
            name: loadingscreen,
            transitionsBuilder: fadeTransitionBuilder,
            child: LoadingScreen(
              key: state.pageKey,
            ),
          );
        },
        routes: [
          GoRoute(
            path: home,
            name: home,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 500),
                name: home,
                transitionsBuilder: fadeTransitionBuilder,
                child: HomePage(
                  key: state.pageKey,
                ),
              );
            },
            redirect: (context, state) {
              if (context.read<PxUserModel>().id == null) {
                return "/$login";
              }
              return null;
            },
            routes: [
              GoRoute(
                path: createclinic,
                name: createclinic,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: createclinic,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: CreateClinicPage(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
              GoRoute(
                path: clinicsch,
                name: clinicsch,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: clinicsch,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: ClinicSchedulePage(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: offline,
            name: offline,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 500),
                name: offline,
                transitionsBuilder: fadeTransitionBuilder,
                child: ServerOfflinePage(
                  key: state.pageKey,
                ),
              );
            },
          ),
          GoRoute(
            path: register,
            name: register,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 500),
                name: register,
                transitionsBuilder: fadeTransitionBuilder,
                child: RegisterPageBasic(
                  key: state.pageKey,
                ),
              );
            },
          ),
          // GoRoute(
          //   path: forgotpassword,
          //   name: forgotpassword,
          //   pageBuilder: (context, state) {
          //     return CustomTransitionPage(
          //       transitionDuration: const Duration(milliseconds: 500),
          //       name: forgotpassword,
          //       transitionsBuilder: fadeTransitionBuilder,
          //       child: ForgotPasswordPage(key: state.pageKey),
          //     );
          //   },
          // ),
          GoRoute(
            path: login,
            name: login,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 500),
                name: login,
                transitionsBuilder: fadeTransitionBuilder,
                child: Loginpage(
                  key: state.pageKey,
                ),
              );
            },
          ),
          GoRoute(
            path: tokenvalidation,
            name: tokenvalidation,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 500),
                name: tokenvalidation,
                transitionsBuilder: fadeTransitionBuilder,
                child: TokenValidationPage(
                  key: state.pageKey,
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
