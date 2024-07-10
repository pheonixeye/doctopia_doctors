import 'package:doctopia_doctors/api/server_status_api/status_api.dart';
import 'package:flutter/material.dart';

// ignore: unused_element
const _healthy = "API is healthy.";

class PxServerStatus extends ChangeNotifier {
  String? _status;
  String? get status => _status;
  String? _message;
  String? get message => _message;

  PxServerStatus({required this.statusService});

  final HxServerStatus statusService;

  Future<String?> checkServerStatus() async {
    _status = await statusService.checkServerStatus();
    notifyListeners();
    if (_status == null) {
      throw Exception("Server Connection Error");
    }
    return _status;
  }
}
