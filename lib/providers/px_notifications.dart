import 'package:doctopia_doctors/api/notifications_api/notifications_api.dart';
import 'package:doctopia_doctors/models/stored_notification.dart';
import 'package:flutter/foundation.dart';

class PxNotifications extends ChangeNotifier {
  final String id;
  final HxNotifications notificationService;

  PxNotifications({
    required this.id,
    required this.notificationService,
  }) {
    fetchNotifications();
  }

  // ignore: unnecessary_nullable_for_final_variable_declarations
  List<StoredNotification>? _notifications;
  List<StoredNotification>? get notifications => _notifications;

  int _page = 1;
  int get page => _page;

  Future<void> fetchTenMore() async {
    _page = _page + 1;
    notifyListeners();
    await fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      final result = await notificationService.fetchNotifications(id, _page);
      _notifications ??= [];
      _notifications!.addAll(result);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateSeenState(String id) async {
    try {
      final updated = await notificationService.updateNotificationSeenState(id);
      final index = _notifications!.indexWhere((e) => e.id == updated.id);
      _notifications![index] = updated;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
