// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';

class HxServerStatus {
  const HxServerStatus();

  Future<String?> checkServerStatus() async {
    try {
      final response = await PocketbaseHelper.pb.health.check();
      return response.code == 200 ? response.message : null;
    } catch (e) {
      rethrow;
    }
  }
}
