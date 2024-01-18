import 'package:doctopia_doctors/pages/create_clinic_page/create_clinic_page.dart';
import 'package:doctopia_doctors/pages/edit_clinic_page/edit_clinic_page.dart';
import 'package:doctopia_doctors/pages/homepage/homepage.dart';
import 'package:doctopia_doctors/pages/loading_screen/loading_screen.dart';
import 'package:doctopia_doctors/pages/login_page/login_page.dart';
import 'package:doctopia_doctors/pages/register_page_basic/register_page_basic.dart';
import 'package:doctopia_doctors/pages/register_page_password/register_page_password.dart';
import 'package:doctopia_doctors/pages/token_validation_page/token_validation_page.dart';
import 'package:flutter/widgets.dart';

class RoutePage {
  final String path;
  final String name;
  final Widget page;

  const RoutePage({
    required this.path,
    required this.name,
    required this.page,
  });

  factory RoutePage.loadingScreen({Key? key}) {
    return RoutePage(
      name: 'loading_screen',
      path: '/',
      page: LoadingScreen(
        key: key,
      ),
    );
  }

  factory RoutePage.homePage({Key? key}) {
    return RoutePage(
      name: 'home_page',
      path: '/home_page',
      page: HomePage(
        key: key,
      ),
    );
  }
  factory RoutePage.registerPageBasic({Key? key}) {
    return RoutePage(
      name: 'register_page_basic',
      path: 'register_page_basic',
      page: RegisterPageBasic(
        key: key,
      ),
    );
  }

  factory RoutePage.registerPagePassword({
    Key? key,
    bool isRegister = true,
  }) {
    return RoutePage(
      name: 'register_page_password',
      path: 'register_page_password',
      page: RegisterPagePassword(
        key: key,
        isRegister: isRegister,
      ),
    );
  }
  factory RoutePage.loginPage({Key? key}) {
    return RoutePage(
      name: 'login_page',
      path: 'login_page',
      page: Loginpage(
        key: key,
      ),
    );
  }

  factory RoutePage.tokenValidationPage({Key? key}) {
    return RoutePage(
      name: 'token_validation',
      path: 'token_validation',
      page: TokenValidationPage(
        key: key,
      ),
    );
  }

  factory RoutePage.createClinicPage({Key? key}) {
    return RoutePage(
      name: 'create_clinic',
      path: 'create_clinic',
      page: CreateClinicPage(
        key: key,
      ),
    );
  }

  factory RoutePage.editClinicPage({Key? key}) {
    return RoutePage(
      name: 'edit_clinic',
      path: 'edit_clinic',
      page: EditClinicPage(
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
