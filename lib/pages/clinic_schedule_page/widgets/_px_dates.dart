import 'package:flutter/material.dart';

class PxDates extends ChangeNotifier {
  PxDates() {
    _initDates();
  }
  final List<DateTime> _dates = [];
  List<DateTime> get dates => _dates;

  void _initDates() {
    //TODO: find a better solution - glitching on tab switch
    //TODO: add only active days from the clinic schedule
    final _today = DateTime.now();
    final _startingDay = DateTime(_today.year, _today.month, _today.day);
    for (var i = 0; i < 30; i++) {
      _dates.add(_startingDay.add(Duration(days: i)));
    }
  }

  void updateDates() {
    final _lastDay = _dates.last;
    for (var i = 0; i < 30; i++) {
      _dates.add(_lastDay.add(Duration(days: i)));
    }
    notifyListeners();
  }
}
