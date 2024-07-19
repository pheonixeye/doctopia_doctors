import 'package:doctopia_doctors/components/notification_overlay.dart';
import 'package:doctopia_doctors/functions/dprint.dart';
import 'package:doctopia_doctors/models/msg.dart';
import 'package:doctopia_doctors/providers/px_overlay.dart';
import 'package:doctopia_doctors/utils/navigator_key.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

void onMessageAppOpen(RemoteMessage msg) {
  late final NotMsg notification;
  dprint("onMessageOpenedAppForeground(${msg.messageId})");
  final title = msg.notification?.title;
  final body = msg.notification?.body;
  try {
    notification = NotMsg(
      id: msg.notification.hashCode.toString(),
      title: title!,
      body: body!,
    );
  } catch (e) {
    dprint(e);
  }

  navigatorKey.currentContext!.read<PxOverlay>().toggleOverlay(
        id: msg.notification!.hashCode.toString(),
        child: NotificationOverlayCard(notification: notification),
        context: navigatorKey.currentContext!,
      );
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
        await Future.delayed(const Duration(seconds: 10), () async {
          return await getFcmToken(retries: retries - 1);
        });
      }
    }
    dprint("NotificationsService().getFcmToken($_token)");

    return null;
  }
}
