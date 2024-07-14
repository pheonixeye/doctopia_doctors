import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
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

  static final _store = PocketbaseHelper.pb.authStore;

  Future<void> _loginFromAuthStore() async {
    //TODO: route to homepage if user is already authenticated;

    // await PocketbaseHelper.pb.collection("users").authRefresh();
    if (_store.isValid) {
      _model = UserModel.fromJson(_store.model);
      _id = _store.model.id;
      _token = _store.token;
      _isLoggedIn = true;
      notifyListeners();
    }
    if (kDebugMode) {
      print("PxUserModel()._loginFromAuthStore($_id)(${_store.isValid})");
    }
  }

  Future<String> loginUserByEmailAndPassword(
    String email,
    String password,
  ) async {
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
      if (kDebugMode) {
        // print(result.toJson());
        // print(id);
        // print(token);
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
      await PocketbaseHelper.pb
          .collection("users")
          .confirmPasswordReset(token, password, confirm);
    } on ClientException catch (e) {
      throw Exception(e.response['message']);
    }
  }
}
