// ignore_for_file: constant_identifier_names

import 'package:doctopia_doctors/env/creds.dart';
import 'package:doctopia_doctors/env/creds_dev.dart';

class ENV {
//!TEST_CLOUD
  static const String TEST_ENDPOINT = CREDS.ENDPOINT;
  static const String TEST_PROJECT_ID = CREDS.PROJECT;
  static const String TEST_API_KEY = CREDS.API_KEY;
//!PROD_CLOUD
  static const String PROD_ENDPOINT = CREDSPROD.ENDPOINT;
  static const String PROD_PROJECT_ID = CREDSPROD.PROJECT_ID;
  static const String PROD_API_KEY = CREDSPROD.API_KEY;
}
