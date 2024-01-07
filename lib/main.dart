import 'package:doctopia_doctors/env/env.dart';
import 'package:doctopia_doctors/firebase_options.dart';
import 'package:doctopia_doctors/localization/app_localizations.dart';
import 'package:doctopia_doctors/providers/_px_main.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:doctopia_doctors/theme/app_theme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'theme/color_schemes.g.dart';
import 'theme/custom_color.g.dart';

import 'package:doctopia_doctors/services/notification_service/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers(ENV('dev')),
      builder: (context, child) {
        return DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            ColorScheme lightScheme;
            ColorScheme darkScheme;

            if (lightDynamic != null && darkDynamic != null) {
              lightScheme = lightDynamic.harmonized();
              lightCustomColors = lightCustomColors.harmonized(lightScheme);

              // Repeat for the dark color scheme.
              darkScheme = darkDynamic.harmonized();
              darkCustomColors = darkCustomColors.harmonized(darkScheme);
            } else {
              // Otherwise, use fallback schemes.
              lightScheme = lightColorScheme;
              darkScheme = darkColorScheme;
            }

            return Consumer2<PxLocale, PxTheme>(
              builder: (context, l, t, c) {
                final isEnglish = l.locale == const Locale('en');
                final textTheme = isEnglish
                    ? GoogleFonts.notoSansTextTheme()
                    : GoogleFonts.notoSansArabicTextTheme();
                return MaterialApp.router(
                  //OPTIONS
                  debugShowCheckedModeBanner: false,
                  title: 'Doctopia',
                  //THEMES
                  theme: AppTheme.theme(
                    colorScheme: lightScheme,
                    extensions: [lightCustomColors],
                    textTheme: textTheme,
                  ),
                  darkTheme: AppTheme.theme(
                    colorScheme: darkScheme,
                    extensions: [darkCustomColors],
                    textTheme: textTheme.apply(
                      displayColor: Colors.white,
                      bodyColor: Colors.white,
                    ),
                  ),
                  themeMode: t.mode,
                  //ROUTER
                  routeInformationProvider: router.routeInformationProvider,
                  routeInformationParser: router.routeInformationParser,
                  routerDelegate: router.routerDelegate,
                  //EASY_LOADING
                  builder: (context, child) {
                    child = EasyLoading.init()(context, child);
                    return child;
                  },
                  //LOCALIZATION
                  locale: l.locale,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                );
              },
            );
          },
        );
      },
    );
  }
}
