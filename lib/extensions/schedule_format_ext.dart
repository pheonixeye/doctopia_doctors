import 'package:doctopia_doctors/extensions/number_translator.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:proklinik_models/proklinik_models.dart';
import 'package:provider/provider.dart';

extension ScheduleFormatExt on Schedule {
  String toFormattedScheduleString(BuildContext context) {
    if (!available) {
      return '';
    } else {
      final startTime = TimeOfDay(
        hour: shifts.first.startH.toInt(),
        minute: shifts.first.startM.toInt(),
      ).format(context);
      final endTime = TimeOfDay(
        hour: shifts.last.endH.toInt(),
        minute: shifts.last.endM.toInt(),
      ).format(context);
      final shiftFormatEn =
          'From $startTime To $endTime'.toArabicNumber(context);
      final shiftFormatAr =
          'من $startTime الي $endTime'.toArabicNumber(context);
      bool isEnglish = context.read<PxLocale>().isEnglish;
      return isEnglish
          ? '${weekday.substring(0, 3).toUpperCase()} $shiftFormatEn'
          : '${WEEKDAYS[intday]?.ar} $shiftFormatAr';
    }
  }
}
