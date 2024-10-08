import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/stored_notification.dart';

class HxNotifications {
  const HxNotifications();

  Future<List<StoredNotification>> fetchNotifications(
      String id, int page) async {
    final result =
        await PocketbaseHelper.pb.collection('notifications').getList(
              filter: "doc_id = '$id'",
              page: page,
              perPage: 10,
              sort: '-created',
            );

    final appNotifications = result.items
        .map((e) => StoredNotification.fromJson(e.toJson()))
        .toList();
    return appNotifications;
  }

  Future<StoredNotification> updateNotificationSeenState(String id) async {
    final result = await PocketbaseHelper.pb.collection('notifications').update(
      id,
      body: {
        'seen': true,
      },
    );
    final not = StoredNotification.fromJson(result.toJson());
    return not;
  }

  Future<void> clearDoctorNotification(String docId) async {
    final result = await PocketbaseHelper.pb
        .collection('notifications')
        .getFullList(filter: "doc_id = '$docId'");
    for (var resultItem in result) {
      await PocketbaseHelper.pb
          .collection('notifications')
          .delete(resultItem.id);
    }
  }
}
