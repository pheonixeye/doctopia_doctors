import 'package:doctopia_doctors/api/errors/connection_excp.dart';
import 'package:doctopia_doctors/api/server_status_api/status_api.dart';
import 'package:flutter/material.dart';

class PxServerStatus extends ChangeNotifier {
  String? _status;
  String? get status => _status;
  String? _message;
  String? get message => _message;

  PxServerStatus({required this.statusService});

  final HxServerStatus statusService;

  Future<String?> checkServerStatus() async {
    try {
      _status = await statusService.checkServerStatus();
      notifyListeners();
      return _status;
    } catch (e) {
      switch (_status) {
        case null:
          _message = ConnectionException(0).message;
          notifyListeners();
          throw ConnectionException(0);
        case 'pass':
          _message = ConnectionException(2).message;
          notifyListeners();
          return _status;
        case 'fail':
          _message = ConnectionException(1).message;
          notifyListeners();
          throw ConnectionException(1);
      }
      rethrow;
    }
  }
}
