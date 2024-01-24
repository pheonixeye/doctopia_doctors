// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  const factory Schedule({
    required String weekday,
    required int intday,
    required int start,
    required int end,
    required int slots,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, Object?> json) =>
      _$ScheduleFromJson(json);

  factory Schedule.initial() {
    return const Schedule(
      weekday: 'Monday',
      intday: 1,
      start: 0,
      end: 0,
      slots: 0,
    );
  }
}
