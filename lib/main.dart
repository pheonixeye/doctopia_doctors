import 'package:doctopia_doctors/firebase_options.dart';
import 'package:doctopia_doctors/localization/app_localizations.dart';
import 'package:doctopia_doctors/providers/_px_main.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
      providers: providers,
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

            return Consumer<PxLocale>(
              builder: (context, l, c) {
                return MaterialApp.router(
                  //OPTIONS
                  debugShowCheckedModeBanner: false,
                  title: 'Doctopia',
                  //THEMES
                  theme: ThemeData(
                    useMaterial3: true,
                    colorScheme: lightScheme,
                    extensions: [lightCustomColors],
                  ),
                  darkTheme: ThemeData(
                    useMaterial3: true,
                    colorScheme: darkScheme,
                    extensions: [darkCustomColors],
                  ),
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
