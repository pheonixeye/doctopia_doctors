import 'dart:convert';

import 'package:doctopia_doctors/firebase_options.dart';
import 'package:doctopia_doctors/functions/dprint.dart';
import 'package:doctopia_doctors/localization/app_localizations.dart';
import 'package:doctopia_doctors/providers/_px_main.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:doctopia_doctors/services/notification_service/notification_service.dart';
import 'package:doctopia_doctors/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onmessage/onmessage.dart';
import 'package:provider/provider.dart';

//TODO: need to switch to asana as it's getting large
//TODO: implement notifications
//TODO: implement news feed page based on speciality

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Set the background messaging handler early on, as a named top-level function
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // if (!kIsWeb) {
  //   await setupFlutterNotifications();
  // }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //app closed
  FirebaseMessaging.onBackgroundMessage(onbackgroundMessage);

  //app opened && in background
  FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedAppBackground);

  //app opened && in foreground
  FirebaseMessaging.onMessage.listen(onMessageOpenedAppForeground);

  OnMessage.instance.stream.listen((MessageEvent event) {
    final data = jsonDecode(event.data.toString());
    dprint(data);
  });

  runApp(const AppProvider());
}

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        return const MyApp();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxTheme>(
      builder: (context, l, t, c) {
        final textTheme = GoogleFonts.cairoTextTheme();
        return MaterialApp.router(
          //OPTIONS
          debugShowCheckedModeBanner: false,
          title: 'ProKliniK',
          //THEMES
          theme: AppTheme.theme(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
            ),
            // extensions: [lightCustomColors],
            textTheme: textTheme,
          ),
          darkTheme: AppTheme.theme(
            colorScheme: const ColorScheme.dark(),
            // extensions: [darkCustomColors],
            textTheme: textTheme.apply(
              displayColor: Colors.white,
              bodyColor: Colors.white,
            ),
          ),
          themeMode: t.mode,
          //ROUTER
          routerConfig: AppRouter.router,
          //EASY_LOADING
          builder: (context, child) {
            child = EasyLoading.init()(context, child);
            return child;
          },
          //LOCALIZATION
          locale: l.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
