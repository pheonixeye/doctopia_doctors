// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String title_en,
    required String title_ar,
    required String body_en,
    required String body_ar,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, Object?> json) =>
      _$AppNotificationFromJson(json);
}
