import 'package:flutter/foundation.dart' show kDebugMode;

void dprint(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}
