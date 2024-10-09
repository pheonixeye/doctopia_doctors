import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:flutter/material.dart';

extension IfAttendanceTranslate on String {
  String ifAttendanceTransalate(BuildContext context) {
    return switch (this) {
      'FiFo' => context.loc.fifo,
      'By Time' => context.loc.byTime,
      _ => this,
    };
  }
}
