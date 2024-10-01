import 'package:flutter/material.dart';
import 'package:proklinik_models/proklinik_models.dart';

extension ScheduleFormatExt on Schedule {
  String toFormattedScheduleString(BuildContext context) {
    if (!available) {
      return '';
    } else {
      final startTime = TimeOfDay(
        hour: shifts.first.startH.toInt(),
        minute: shifts.first.startM.toInt(),
      );
      final endTime = TimeOfDay(
        hour: shifts.last.endH.toInt(),
        minute: shifts.last.endM.toInt(),
      );
      final shiftFormat =
          'From ${startTime.format(context)} To ${endTime.format(context)}';
      return '${weekday.substring(0, 3).toUpperCase()} $shiftFormat';
    }
  }
}
