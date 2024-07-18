import 'package:doctopia_doctors/services/local_database_service/local_database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PxLocale extends ChangeNotifier {
  final BuildContext context;

  PxLocale(this.context);

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  bool get isEnglish => _locale == const Locale('en');

  Future<void> changeLocale() async {
    if (_locale.languageCode == 'en') {
      _locale = const Locale('ar');
      await context.read<PxLocalDatabase>().saveLanguageToDb('ar');
    } else if (_locale.languageCode == 'ar') {
      _locale = const Locale('en');
      await context.read<PxLocalDatabase>().saveLanguageToDb('en');
    }
    notifyListeners();
  }

  Future<void> setLocaleFromLocalDb() async {
    _locale = Locale(context.read<PxLocalDatabase>().language);
    notifyListeners();
  }
}
