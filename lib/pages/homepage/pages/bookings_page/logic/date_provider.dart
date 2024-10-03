import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetsDateProvider {
  final List<int> _years;

  static final Map<int, int> _monthToDays = _initMonthToDays();

  static final _today = DateTime.now();

  static const int _startingYear = 2024;

  static const Map<int, String> _months = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  WidgetsDateProvider() : _years = [..._gapYears()];

  static Map<int, int> _initMonthToDays() {
    final bool isLeapYear = _today.year % 4 == 0;
    Map<int, int> _data = {};
    _months.keys.map((e) {
      _data[e] = switch (e) {
        1 || 3 || 5 || 7 || 8 || 10 || 12 => 31,
        2 => isLeapYear ? 29 : 28,
        4 || 6 || 9 || 11 => 30,
        _ => throw Exception('Unknown Month.'),
      };
      // print(e);
    }).toList();
    // print(_data);
    return _data;
  }

  List<int> daysPerMonth(int? month) {
    if (month == null) {
      return [];
    }
    int _dpm = _monthToDays[month]!;
    List<int> _days = [];
    for (var i = 1; i <= _dpm; i++) {
      _days.add(i);
    }
    return _days;
  }

  List<int> get years => _years;

  Map<int, String> get months => _months;

  static List<int> _gapYears() {
    if (_today.year != _startingYear) {
      List<int> _result = [];
      final diff = _today.year - _startingYear;
      for (var i = 0; i <= diff; i++) {
        _result.add((_startingYear + i));
      }
      return _result;
    } else {
      return [_startingYear];
    }
  }
}

extension TranslateMonth on String {
  String ifMonthTranslate(BuildContext context) {
    final isEnglish = context.read<PxLocale>().isEnglish;
    try {
      final foundMonth =
          WidgetsDateProvider._months.values.firstWhere((e) => this == e);
      final translatedMonth = switch (foundMonth) {
        "January" => "يناير",
        "February" => "فبراير",
        "March" => "مارس",
        "April" => "ابريل",
        "May" => "مايو",
        "June" => "يونيو",
        "July" => "يوليو",
        "August" => "اغسطس",
        "September" => "سبتمبر",
        "October" => "اكتوبر",
        "November" => "نوفمبر",
        "December" => "ديسمبر",
        _ => throw UnimplementedError(),
      };
      return isEnglish ? foundMonth : translatedMonth;
    } catch (e) {
      return '';
    }
  }
}
