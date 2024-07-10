import 'dart:convert';

String decodedExpString(String exp) {
  final decoded = jsonDecode(exp);
  return decoded["message"] as String;
}
