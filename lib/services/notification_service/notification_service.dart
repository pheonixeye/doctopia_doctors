import 'package:doctopia_doctors/functions/dprint.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma("vm:entry-point")
Future<void> onbackgroundMessage(RemoteMessage remoteMessage) async {
  if (remoteMessage.notification != null) {
    //TODO:
    dprint(remoteMessage.toString());
  }
}

void onMessageOpenedAppBackground(RemoteMessage remoteMessage) {
  if (remoteMessage.notification != null) {
    dprint(remoteMessage.toString());
  }
}

void onMessageOpenedAppForeground(RemoteMessage remoteMessage) {
  if (remoteMessage.notification != null) {
    dprint(remoteMessage.toString());
  }
}

class NotificationsService {
  NotificationsService();
  // ignore: constant_identifier_names
  static const String APIKEY =
      "BIVnTiVKKbzjOeWhQ-8JdmP8SlMOvyIRp3b5qX39JfWHdJkFv2oRgcd0hNCFtbibu5yimpNa8-nmBmwjIbjFqM0";

  String? _token;
  String? get token => _token;

  Future<void> init() async {
    final permission = await FirebaseMessaging.instance.requestPermission();
    switch (permission.authorizationStatus) {
      case AuthorizationStatus.authorized:
        _token = await getFcmToken();
        break;
      case AuthorizationStatus.denied:
        break;
      case AuthorizationStatus.notDetermined:
        _token = await getFcmToken();
        break;
      case AuthorizationStatus.provisional:
        _token = await getFcmToken();
        break;
    }
    dprint("NotificationsService().init()");
  }

  Future<String?> getFcmToken({int retries = 3}) async {
    try {
      final _token = await FirebaseMessaging.instance.getToken(
        vapidKey: APIKEY,
      );
      return _token;
    } catch (e) {
      if (retries > 0) {
        await Future.delayed(const Duration(seconds: 5), () async {
          return await getFcmToken(retries: retries - 1);
        });
      }
    }
    dprint("NotificationsService().getFcmToken($_token)");

    return null;
  }
}
