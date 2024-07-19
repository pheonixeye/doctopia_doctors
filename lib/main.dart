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
import 'package:provider/provider.dart';

//todo: need to switch to asana as it's getting large
//todo: implement notifications
//TODO: implement news feed page based on speciality

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  dprint('_firebaseMessagingBackgroundHandler(${message.messageId})');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //app closed
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const AppProvider());
}

class AppProvider extends StatefulWidget {
  const AppProvider({super.key});

  @override
  State<AppProvider> createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider> {
  @override
  void initState() {
    //app opened && in background
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageAppOpen);

    //app opened && in foreground
    FirebaseMessaging.onMessage.listen(onMessageAppOpen);

    super.initState();
  }

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
            colorScheme: const ColorScheme.dark(
              primary: Colors.green,
            ),
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
