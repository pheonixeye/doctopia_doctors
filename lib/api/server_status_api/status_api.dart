// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:pocketbase/pocketbase.dart';

class HxServerStatus {
  const HxServerStatus();

  Future<String?> checkServerStatus({int retries = 3}) async {
    if (retries <= 0) {
      throw ClientException();
    }
    final _subtracted = retries - 1;
    try {
      final response = await PocketbaseHelper.pb.health.check();
      return response.code == 200 ? response.message : null;
    } catch (e) {
      await Future.delayed(const Duration(seconds: 3), () async {
        await checkServerStatus(retries: _subtracted);
      });
    }
    return null;
  }
}
