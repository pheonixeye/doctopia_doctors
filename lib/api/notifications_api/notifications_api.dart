import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/app_notification.dart';

class HxNotifications {
  const HxNotifications();

  Future<List<AppNotification>> fetchNotifications(String id, int page) async {
    final result =
        await PocketbaseHelper.pb.collection('notifications').getList(
              filter: "doc_id = '$id'",
              page: page,
              perPage: 10,
              sort: '+created',
            );

    final appNotifications =
        result.items.map((e) => AppNotification.fromJson(e.toJson())).toList();
    return appNotifications;
  }
}
