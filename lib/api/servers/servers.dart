// ignore_for_file: library_prefixes

import 'package:doctopia_doctors/env/env.dart';
import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:dart_appwrite/dart_appwrite.dart' as serverSDK;

class Servers {
  const Servers._();

  static Servers get instance => const Servers._();
}

class Server {
  final String name;
  final clientSDK.Client clientClient;
  final serverSDK.Client serverClient;

  const Server._({
    required this.name,
    required this.clientClient,
    required this.serverClient,
  });

  factory Server.main(String environment) {
    final env = ENV(environment);
    return Server._(
      name: environment,
      clientClient:
          clientSDK.Client(endPoint: env.creds.ENDPOINT, selfSigned: true)
              .setProject(env.creds.PROJECT)
              .addHeader("X-RateLimit-Limit", "5000"),
      serverClient:
          serverSDK.Client(endPoint: env.creds.ENDPOINT, selfSigned: true)
              .setProject(env.creds.PROJECT)
              .setKey(env.creds.API_KEY),
    );
  }
}
