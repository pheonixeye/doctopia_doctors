import 'package:flutter/material.dart';

class PxDates extends ChangeNotifier {
  PxDates() {
    initDates();
  }

  final List<DateTime> _dates = [];
  List<DateTime> get dates => _dates;

  void initDates([List<int> openDates = const []]) {
    //TODO: find a better solution - glitching on tab switch
    //TODO: add only active days from the clinic schedule
    final _today = DateTime.now();
    final _startingDay = DateTime(_today.year, _today.month, _today.day);
    for (var i = 0; i < 30; i++) {
      _dates.add(_startingDay.add(Duration(days: i)));
      // if (openDates.contains(_startingDay.add(Duration(days: i)).weekday)) {}
    }
  }

  void updateDates([List<int> openDates = const []]) {
    final _lastDay = _dates.last;
    for (var i = 0; i < 30; i++) {
      _dates.add(_lastDay.add(Duration(days: i)));
      // if (openDates.contains(_lastDay.add(Duration(days: i)).weekday)) {}
      notifyListeners();
    }
  }
}
