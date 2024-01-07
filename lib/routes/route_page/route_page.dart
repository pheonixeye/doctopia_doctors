import 'package:doctopia_doctors/pages/homepage/homepage.dart';
import 'package:doctopia_doctors/pages/loading_screen/loading_screen.dart';
import 'package:doctopia_doctors/pages/login_page/login_page.dart';
import 'package:doctopia_doctors/pages/register_page_basic/register_page_basic.dart';
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
  factory RoutePage.loginPage({Key? key}) {
    return RoutePage(
      name: 'login_page',
      path: 'login_page',
      page: Loginpage(
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
