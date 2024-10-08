import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:flutter/material.dart';

extension IfVisitTypeTranslate on String? {
  String? ifVisitTypeTranslate(BuildContext context) {
    return switch (this) {
      'Consultation' => context.loc.consultation,
      'Followup' => context.loc.followup,
      _ => this,
    };
  }
}

extension BooleanEmoji on bool {
  String emoji() {
    return switch (this) {
      true => '✔️',
      false => '❌',
    };
  }
}
