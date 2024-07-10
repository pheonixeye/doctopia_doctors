import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/user/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

class PxUserModel extends ChangeNotifier {
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
        print(result.toJson());
      }
      _model = UserModel.fromJson(result.toJson());
      return _model!;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  Future<void> loginUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result =
          await PocketbaseHelper.pb.collection("users").authWithPassword(
                email,
                password,
              );
      _id = result.record!.id;
      _token = result.token;
      _isLoggedIn = true;
      notifyListeners();
      if (kDebugMode) {
        print(id);
        print(token);
      }
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  void logout() {
    _id = null;
    _token = null;
    _isLoggedIn = false;
    notifyListeners();

    PocketbaseHelper.pb.authStore.clear();
  }
}
