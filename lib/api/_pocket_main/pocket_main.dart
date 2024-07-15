import 'package:pocketbase/pocketbase.dart';

class PocketbaseHelper {
  static final PocketBase _pb = PocketBase(
      const String.fromEnvironment("PB_SERVER").isEmpty
          ? "http://127.0.0.1:8090/"
          : const String.fromEnvironment("PB_SERVER"));

  static PocketBase get pb => _pb;

  static final AuthStore _store = pb.authStore;

  static AuthStore get store => _store;
}
