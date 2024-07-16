// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/functions/dprint.dart';
import 'package:doctopia_doctors/models/user/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

class PxUserModel extends ChangeNotifier {
  PxUserModel() {
    _loginFromAuthStore();
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
      final result = await PocketbaseHelper.pb.collection("users").create(
            body: value.toPocketbaseJson(),
          );
      if (kDebugMode) {
        // print(result.toJson());
      }
      _model = UserModel.fromJson(result.toJson());
      return _model!;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  void _loginFromAuthStore() {
    //TODO: route to homepage if user is already authenticated;

    if (PocketbaseHelper.pb.authStore.isValid) {
      _model = UserModel.fromJson(PocketbaseHelper.pb.authStore.model);
      _id = PocketbaseHelper.pb.authStore.model.id;
      _token = PocketbaseHelper.pb.authStore.token;
      _isLoggedIn = true;
      notifyListeners();
    }
    dprint(
        "PxUserModel()._loginFromAuthStore($_token)(${PocketbaseHelper.pb.authStore.isValid})");
  }

  Future<String> loginUserByEmailAndPassword(
    String email,
    String password, [
    bool rememberMe = false,
  ]) async {
    try {
      final result =
          await PocketbaseHelper.pb.collection("users").authWithPassword(
                email,
                password,
              );
      _model = UserModel.fromJson(result.record!.toJson());
      _id = result.record?.id;
      _token = result.token;
      _isLoggedIn = true;

      notifyListeners();

      if (rememberMe) {
        PocketbaseHelper.pb.authStore.save(result.token, result.record);
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

  Future<void> confirmResetPassword({
    required String token,
    required String password,
    required String confirm,
  }) async {
    try {
      await PocketbaseHelper.pb.collection("users").confirmPasswordReset(
            token,
            password,
            confirm,
          );
    } on ClientException catch (e) {
      throw Exception(e.response['message']);
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
      final result = await PocketbaseHelper.pb.collection("users").update(
        id!,
        body: {
          "fcm_token": _fcm_token,
        },
      );
      _model = UserModel.fromJson(result.toJson());
      notifyListeners();
    }
    dprint(
        "PxUserModel().saveFcmToken(${_token == _model!.fcm_token ? 'SameToken' : _model?.fcm_token})");
  }
}
