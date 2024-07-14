// ignore_for_file: constant_identifier_names

import 'package:doctopia_doctors/api/clinic_api/clinic_api.dart';
import 'package:doctopia_doctors/api/clinic_visits_api/hx_clinic_visits.dart';
import 'package:doctopia_doctors/api/doctor_api/hx_doctor.dart';
import 'package:doctopia_doctors/api/invoices_api/invoices_api.dart';
import 'package:doctopia_doctors/api/reviews_api/reviews_api.dart';
import 'package:doctopia_doctors/api/scrapper_api/scrapper_api.dart';
import 'package:doctopia_doctors/pages/clinic_schedule_page/clinic_schedule_page.dart';
import 'package:doctopia_doctors/pages/create_clinic_page/create_clinic_page.dart';
import 'package:doctopia_doctors/pages/homepage/homepage.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/bookings_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/clinics_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/invoices_page/invoices_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/news_feed_page/news_feed_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/notifications_page/notifications_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/profile_page/profile_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/reviews_page/reviews_page.dart';
import 'package:doctopia_doctors/pages/homepage/pages/settings_page/settings_page.dart';
import 'package:doctopia_doctors/pages/loading_screen/loading_screen.dart';
import 'package:doctopia_doctors/pages/login_page/login_page.dart';
import 'package:doctopia_doctors/pages/register_page_basic/register_page_basic.dart';
import 'package:doctopia_doctors/pages/server_offline_page/server_offline_page.dart';
import 'package:doctopia_doctors/pages/token_validation_page/token_validation_page.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_invoices.dart';
import 'package:doctopia_doctors/providers/px_nav.dart';
import 'package:doctopia_doctors/providers/px_reviews.dart';
import 'package:doctopia_doctors/providers/px_scrapper.dart';
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
  static const String feed = 'app/:id/feed';
  static const String bookings = 'app/:id/bookings';
  static const String profile = 'app/:id/profile';
  static const String clinics = 'app/:id/clinics';
  static const String notifications = 'app/:id/notifications';
  static const String invoices = 'app/:id/invoices';
  static const String reviews = 'app/:id/reviews';
  static const String settings = 'app/:id/settings';

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
          //todo: convert home to a shell route
          //todo: add all home children to be regular routes
          ShellRoute(
            pageBuilder: (context, state, child) {
              final id = state.pathParameters["id"] as String;
              final key = ValueKey(id);
              return CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 500),
                name: "shell",
                transitionsBuilder: fadeTransitionBuilder,
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      key: key,
                      create: (context) => PxDoctor(
                        doctorService: HxDoctor(),
                        id: id,
                      ),
                    ),
                    ChangeNotifierProvider(
                      create: (context) => PxNav(),
                    ),
                  ],
                  child: HomePage(
                    key: key,
                    child: child,
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
                path: home, //app/:id?page=1
                name: home,
                pageBuilder: (context, state) {
                  final page = state.uri.queryParameters["page"] ?? "1";
                  final key = ValueKey(page);
                  print(page);

                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: home,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: ChangeNotifierProvider(
                      key: key,
                      create: (context) => PxScrapper(
                        scrapperService: HxScrapper(),
                        page: int.parse(page),
                      ),
                      child: NewsFeedPage(
                        key: key,
                      ),
                    ),
                  );
                },
                redirect: (context, state) {
                  //HACK: supposed to save state
                  final page = state.uri.queryParameters["page"];
                  final id = state.pathParameters["id"];
                  if (page == null) {
                    return "/app/$id?page=1";
                  }
                  return null;
                },
              ),
              GoRoute(
                path: bookings,
                name: bookings,
                pageBuilder: (context, state) {
                  final id = state.pathParameters["id"] as String;
                  final key = ValueKey(id);
                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: bookings,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: MultiProvider(
                      key: key,
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => PxClinicVisits(
                            doc_id: id,
                            visitsService: HxClinicVisits(),
                          ),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => PxClinics(
                            id: id,
                            clinicService: HxClinic(),
                          ),
                        ),
                      ],
                      child: BookingsPage(
                        key: state.pageKey,
                      ),
                    ),
                  );
                },
              ),
              GoRoute(
                path: clinics,
                name: clinics,
                pageBuilder: (context, state) {
                  final id = state.pathParameters["id"] as String;
                  final key = ValueKey(id);
                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: clinics,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: ChangeNotifierProvider(
                      key: key,
                      create: (context) => PxClinics(
                        id: id,
                        clinicService: HxClinic(),
                      ),
                      child: ClinicsPage(
                        key: key,
                      ),
                    ),
                  );
                },
                routes: [
                  //#inside clinics
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
                      // final clinicId =
                      //     state.pathParameters["clinicid"] as String;
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
              //# continue shell route
              GoRoute(
                path: profile,
                name: profile,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: profile,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: ProfilePage(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
              GoRoute(
                path: notifications,
                name: notifications,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: notifications,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: NotificationsPage(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
              GoRoute(
                path: invoices,
                name: invoices,
                pageBuilder: (context, state) {
                  final id = state.pathParameters["id"] as String;
                  final key = ValueKey(id);

                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: invoices,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: ChangeNotifierProvider(
                      key: key,
                      create: (context) => PxInvoices(
                        doc_id: id,
                        invoicesService: HxInvoices(),
                      ),
                      child: InvoicesPage(
                        key: key,
                      ),
                    ),
                  );
                },
              ),
              GoRoute(
                path: reviews,
                name: reviews,
                pageBuilder: (context, state) {
                  final id = state.pathParameters["id"] as String;
                  final key = ValueKey(id);

                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: reviews,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: ChangeNotifierProvider(
                      key: key,
                      create: (context) => PxReviews(
                        id: id,
                        reviewsService: HxReviews(),
                      ),
                      child: ReviewsPage(
                        key: state.pageKey,
                      ),
                    ),
                  );
                },
              ),
              GoRoute(
                path: settings,
                name: settings,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    transitionDuration: const Duration(milliseconds: 500),
                    name: settings,
                    transitionsBuilder: fadeTransitionBuilder,
                    child: SettingsPage(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          //# end of shell route

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
