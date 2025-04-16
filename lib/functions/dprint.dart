import 'dart:convert';

import 'package:flutter/foundation.dart' show kDebugMode;

void dprint(Object? object) {
  if (kDebugMode) {
    final String prettyprint = JsonEncoder.withIndent('  ').convert(object);
    print(prettyprint);
  }
}
