// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/api/user_model_api/user_model_api.dart';
import 'package:doctopia_doctors/functions/dprint.dart';
import 'package:doctopia_doctors/services/local_database_service/local_database_service.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:proklinik_models/models/user_model.dart';
import 'package:provider/provider.dart';

class PxUserModel extends ChangeNotifier {
  final BuildContext context;
  final HxUserModel userService;
  PxUserModel({
    required this.context,
    required this.userService,
  }) {
    _loginFromAuthStore(context);
  }

  UserModel? _model;
  UserModel? get model => _model;

  String? _token;
  String? get token => _token;

  String? _id;
  String? get id => _id;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<UserModel> createUserAccount(UserModel value) async {
    try {
      _model = await userService.createUserAccount(value);
      notifyListeners();
      return _model!;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  void _loginFromAuthStore(BuildContext context) {
    //TODO: route to homepage if user is already authenticated;
    final localDb = context.read<PxLocalDatabase>();
    if (localDb.token != null && localDb.userModel != null) {
      try {
        _model = UserModel.fromJson(jsonDecode(localDb.userModel!));
        _id = _model!.id;
        _token = localDb.token;
        _isLoggedIn = true;
        PocketbaseHelper.pb.authStore.save(_token!, _model);
        notifyListeners();
      } catch (e) {
        _model = null;
        _id = null;
        _token = null;
        _isLoggedIn = false;
        PocketbaseHelper.pb.authStore.clear();
        notifyListeners();
      }
    }
    dprint("PxUserModel()._loginFromAuthStore(${localDb.userModel})");
  }

  Future<String> loginUserByEmailAndPassword(
    String email,
    String password, [
    bool rememberMe = false,
  ]) async {
    try {
      final result = await userService.loginUserByEmailAndPassword(
        email,
        password,
      );
      _model = UserModel.fromJson(result.record!.toJson());
      _id = result.record?.id;
      _token = result.token;
      _isLoggedIn = true;

      notifyListeners();

      if (rememberMe && context.mounted) {
        await context.read<PxLocalDatabase>().saveCredentials(
              result.token,
              result.record!.toString(),
            );
      }

      return _id!;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  void logout() {
    _id = null;
    _token = null;
    _isLoggedIn = false;
    _model = null;
    PocketbaseHelper.pb.authStore.clear();
    context.read<PxLocalDatabase>().clearCredentials();
    notifyListeners();

    // PocketbaseHelper.pb.authStore.clear();
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      await PocketbaseHelper.pb.collection("users").requestPasswordReset(email);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String? _fcm_token;
  String? get fcm_token => _fcm_token;

  void setFcmToken(String? value) {
    _fcm_token = value;
    notifyListeners();
    // dprint("PxUserModel().setFcmToken($value)");
  }

  Future<void> saveFcmToken() async {
    if (_token != null && _token != _model!.fcm_token) {
      final result = await userService.updateUserModel(
        id: id!,
        update: {
          "fcm_token": _fcm_token,
        },
      );
      _model = result;
      notifyListeners();
    }
    dprint(
        "PxUserModel().saveFcmToken(${_token == _model!.fcm_token ? 'SameToken' : _model?.fcm_token})");
  }

  Future<UserModel?> updateUserModel(Map<String, dynamic> update) async {
    try {
      final result = await userService.updateUserModel(id: id!, update: update);
      _model = result;
      notifyListeners();
      return _model!;
    } on ClientException catch (e) {
      dprint(e.response['message']);
      return null;
    }
  }
}
