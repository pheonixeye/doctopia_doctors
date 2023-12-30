import 'package:doctopia_doctors/localization/app_localizations.dart';
import 'package:flutter/material.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get t => AppLocalizations.of(this);
}
