// ignore_for_file: constant_identifier_names

import 'package:doctopia_doctors/env/creds.dart';
import 'package:doctopia_doctors/env/creds_dev.dart';
import 'package:doctopia_doctors/env/creds_prod.dart';

class ENV {
  final String env;
  late CREDS creds;
  ENV(this.env) {
    creds = switch (env) {
      'dev' => CREDSDEV(),
      'prod' => CREDSPROD(),
      _ => throw UnimplementedError(),
    };
  }
}
