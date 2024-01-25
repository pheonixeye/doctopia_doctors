// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'package:dart_appwrite/dart_appwrite.dart' as serverSDK;

import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';

class HxServerStatus {
  final ENV env;
  late final Server server;
  late final serverSDK.Health server_health;

  HxServerStatus({required this.env}) {
    server = Server.main(env.env);
    server_health = serverSDK.Health(server.serverAPI);
  }

  Future<String> checkServerStatus() async {
    try {
      final response = await server_health.get();
      return response.status;
    } catch (e) {
      rethrow;
    }
  }
}
