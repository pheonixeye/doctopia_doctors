import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/models/app_notification.dart';
import 'package:doctopia_doctors/providers/px_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          leading: CircleAvatar(),
          title: Text("My Notifications"),
        ),
        Consumer<PxNotifications>(
          builder: (context, n, _) {
            while (n.notifications == null) {
              return const Padding(
                padding: EdgeInsets.only(top: 200.0),
                child: CentralLoading(),
              );
            }
            while (n.notifications!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 200.0),
                child: Center(
                  child: Card.outlined(
                    elevation: 6,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("You Are All Caught Up."),
                    ),
                  ),
                ),
              );
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...(n.notifications as List<AppNotification>).map((e) {
                  return ListTile(
                    title: Text(e.toString()),
                  );
                }),
              ],
            );
          },
        ),
      ],
    );
  }
}
