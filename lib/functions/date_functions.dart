import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Map<int, (String, String)> _intdayToWeekday = {
  1: ("Monday", "الاثنين"),
  2: ("Tuesday", "الثلاثاء"),
  3: ("Wednesday", "الاربعاء"),
  4: ("Thursday", "الخميس"),
  5: ("Friday", "الجمعة"),
  6: ("Saturday", "السبت"),
  7: ("Sunday", "الاحد"),
};

String getWeekday(int key, bool isEnglish) {
  return isEnglish ? _intdayToWeekday[key]!.$1 : _intdayToWeekday[key]!.$2;
}

extension IfWeekdayTranslate on String {
  String ifWeekdayTranslate(BuildContext context) {
    bool isEnglish = context.read<PxLocale>().isEnglish;
    return switch (this) {
      "Monday" => isEnglish ? this : 'الاثنين',
      "Tuesday" => isEnglish ? this : 'الثلاثاء',
      "Wednesday" => isEnglish ? this : 'الاربعاء',
      "Thursday" => isEnglish ? this : 'الخميس',
      "Friday" => isEnglish ? this : 'الجمعة',
      "Saturday" => isEnglish ? this : 'السبت',
      "Sunday" => isEnglish ? this : 'الاحد',
      _ => this,
    };
  }
}

/// format time function - takes an hour integer and returns am/pm formatted time
String fT(int hour, int min) {
  return switch (hour) {
    < 12 => '$hour:$min A.M.',
    > 12 => '${hour - 12}:$min P.M.',
    == 12 => '$hour:$min P.M.',
    _ => 'Unsupported Time Format.',
  };
}
