import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/models/stored_notification.dart';
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
                ...(n.notifications as List<StoredNotification>).map(
                  (e) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        selected: e.seen,
                        selectedTileColor: Theme.of(context)
                            .appBarTheme
                            .backgroundColor
                            ?.withOpacity(0.2),
                        onTap: () {
                          //TODO: Navigate according to notification type to coresponding page with
                          //emphasis on data eg: booking => nav to booking with selected date
                        },
                        leading: Checkbox(
                          value: e.seen,
                          onChanged: (value) async {
                            //TODO: change seen state
                            BuildContext? dialogContext;
                            showDialog(
                                context: context,
                                builder: (context) {
                                  dialogContext = context;
                                  return const CentralLoading();
                                });
                            await n.updateSeenState(e.id);
                            if (dialogContext != null &&
                                dialogContext!.mounted) {
                              Navigator.pop(dialogContext!);
                            }
                          },
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.title),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.body ?? ''),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
