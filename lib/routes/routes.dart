// ignore_for_file: constant_identifier_names

import 'package:doctopia_doctors/api/clinic_api/clinic_api.dart';
import 'package:doctopia_doctors/api/doctor_api/hx_doctor.dart';
import 'package:doctopia_doctors/pages/clinic_schedule_page/clinic_schedule_page.dart';
import 'package:doctopia_doctors/pages/create_clinic_page/create_clinic_page.dart';
import 'package:doctopia_doctors/pages/homepage/homepage.dart';
import 'package:doctopia_doctors/pages/loading_screen/loading_screen.dart';
import 'package:doctopia_doctors/pages/login_page/login_page.dart';
import 'package:doctopia_doctors/pages/register_page_basic/register_page_basic.dart';
import 'package:doctopia_doctors/pages/server_offline_page/server_offline_page.dart';
import 'package:doctopia_doctors/pages/token_validation_page/token_validation_page.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
// import 'package:doctopia_doctors/routes/route_page/route_page.dart';
import 'package:doctopia_doctors/routes/transitions.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static const String loadingscreen = '/';
  static const String home = 'app/:id';
  static const String login = 'login';
  static const String register = 'register';
  static const String createclinic = 'createclinic';
  static const String offline = 'offline';
  static const String forgotpassword = 'forgotpassword';
  static const String tokenvalidation = 'tokenvalidation';
  static const String sch = 'sch/:clinicid';

  static final GoRouter router = GoRouter(
    initialLocation: loadingscreen,
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
          // ShellRoute(
          //   pageBuilder: (context, state, child) {
          //TODO: convert home to a shell route
          //TODO: add all home children to be regular routes
          //   },
          //   routes: [],
          // ),
          GoRoute(
            path: home,
            name: home,
            pageBuilder: (context, state) {
              final id = state.pathParameters["id"] as String;
              final key = ValueKey(id);
              return CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 500),
                name: home,
                transitionsBuilder: fadeTransitionBuilder,
                child: ChangeNotifierProvider(
                  key: key,
                  create: (context) => PxDoctor(
                    doctorService: HxDoctor(),
                    id: id,
                  ),
                  child: HomePage(
                    key: key,
                  ),
                ),
              );
            },
            redirect: (context, state) {
              if (context.read<PxUserModel>().id == null ||
                  state.pathParameters["id"] == null) {
                return "/$login";
              }
              return null;
            },
            routes: [
              GoRoute(
                path: createclinic,
                name: createclinic,
                pageBuilder: (context, state) {
                  final id = state.pathParameters["id"] as String;
                  final key = ValueKey(id);
                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: createclinic,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: ChangeNotifierProvider(
                      key: key,
                      create: (context) => PxClinics(
                        clinicService: HxClinic(),
                        id: id,
                      ),
                      child: CreateClinicPage(
                        key: state.pageKey,
                      ),
                    ),
                  );
                },
              ),
              GoRoute(
                path: sch,
                name: sch,
                pageBuilder: (context, state) {
                  final id = state.pathParameters["id"] as String;
                  final clinicId = state.pathParameters["clinicid"] as String;
                  final key = ValueKey(id);
                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: sch,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: ChangeNotifierProvider(
                      key: key,
                      create: (context) => PxClinics(
                        clinicService: HxClinic(),
                        id: id,
                      ),
                      child: ClinicSchedulePage(
                        key: key,
                      ),
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
