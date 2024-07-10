// ignore_for_file: library_prefixes

import 'package:doctopia_doctors/env/env.dart';
import 'package:appwrite/appwrite.dart' as clientSDK;

class Servers {
  const Servers._();

  static Servers get instance => const Servers._();
}

class Server {
  final String name;
  final clientSDK.Client clientAPI;
  // final serverSDK.Client serverAPI;

  const Server._({
    required this.name,
    required this.clientAPI,
    // required this.serverAPI,
  });

  factory Server.main(String environment) {
    final env = ENV(environment);
    return Server._(
      name: environment,
      clientAPI:
          clientSDK.Client(endPoint: env.creds.ENDPOINT, selfSigned: true)
              .setProject(env.creds.PROJECT)
              // .addHeader("X-RateLimit-Limit", "5000")
              .addHeader("Access-Control-Allow-Origin", "*"),
    );
  }
}
