import 'package:doctopia_doctors/api/app_constants_api/app_constants_api.dart';
import 'package:doctopia_doctors/functions/dprint.dart';
import 'package:doctopia_doctors/models/app_constants_model/app_constants_model.dart';
import 'package:flutter/material.dart';

class PxAppConstants extends ChangeNotifier {
  final AppConstantsApi service;

  PxAppConstants({required this.service}) {
    _init();
  }

  static AppConstantsResponseModel? _model;
  AppConstantsResponseModel? get model => _model;

  Future<void> _init() async {
    _model = await service.fetchBaseModels();
    notifyListeners();
    dprint('PxAppConstants._init()');
  }
}
