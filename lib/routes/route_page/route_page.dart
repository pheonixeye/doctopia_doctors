import 'package:doctopia_doctors/pages/clinic_schedule_page/clinic_schedule_page.dart';
import 'package:doctopia_doctors/pages/create_clinic_page/create_clinic_page.dart';
import 'package:doctopia_doctors/pages/homepage/homepage.dart';
import 'package:doctopia_doctors/pages/loading_screen/loading_screen.dart';
import 'package:doctopia_doctors/pages/login_page/login_page.dart';
import 'package:doctopia_doctors/pages/register_page_basic/register_page_basic.dart';
import 'package:doctopia_doctors/pages/register_page_password/register_page_password.dart';
import 'package:doctopia_doctors/pages/server_offline_page/server_offline_page.dart';
import 'package:doctopia_doctors/pages/token_validation_page/token_validation_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RoutePage {
  final String path;
  final String name;
  final Widget page;
  final List<RouteBase>? routes;

  const RoutePage({
    required this.path,
    required this.name,
    required this.page,
    this.routes,
  });

  factory RoutePage.loadingScreen({Key? key, List<GoRoute>? routes}) {
    return RoutePage(
      name: '/',
      path: '/',
      page: LoadingScreen(
        key: key,
      ),
      routes: routes,
    );
  }
  factory RoutePage.serverOfflinePage({Key? key, List<GoRoute>? routes}) {
    return RoutePage(
      name: 'offline',
      path: 'offline',
      page: ServerOfflinePage(
        key: key,
      ),
    );
  }

  factory RoutePage.homePage({Key? key, List<GoRoute>? routes}) {
    return RoutePage(
      name: 'home',
      path: 'home',
      page: HomePage(
        key: key,
      ),
    );
  }
  factory RoutePage.registerPageBasic({Key? key, List<GoRoute>? routes}) {
    return RoutePage(
      name: 'register',
      path: 'register',
      page: RegisterPageBasic(
        key: key,
      ),
    );
  }

  factory RoutePage.forgotPassword(
      {Key? key, bool isRegister = true, List<GoRoute>? routes}) {
    return RoutePage(
      name: 'forgotpassword',
      path: 'forgotpassword',
      page: RegisterPagePassword(
        key: key,
        isRegister: isRegister,
      ),
    );
  }
  factory RoutePage.loginPage({Key? key, List<GoRoute>? routes}) {
    return RoutePage(
      name: 'login',
      path: 'login',
      page: Loginpage(
        key: key,
      ),
    );
  }

  factory RoutePage.tokenValidationPage({Key? key, List<GoRoute>? routes}) {
    return RoutePage(
      name: 'tokenvalidation',
      path: 'tokenvalidation',
      page: TokenValidationPage(
        key: key,
      ),
    );
  }

  factory RoutePage.createClinicPage({Key? key, List<GoRoute>? routes}) {
    return RoutePage(
      name: 'createclinic',
      path: 'createclinic',
      page: CreateClinicPage(
        key: key,
      ),
    );
  }

  factory RoutePage.clinicSchedulePage({Key? key}) {
    return RoutePage(
      name: 'clinicschedule',
      path: 'clinicschedule',
      page: ClinicSchedulePage(
        key: key,
      ),
    );
  }

  // static final List<RoutePage> list = [
  //   RoutePage.loadingScreen(),
  //   RoutePage.registerPageBasic(),
  //   RoutePage.homePage(),
  //   RoutePage.loginPage(),
  // ];
}
