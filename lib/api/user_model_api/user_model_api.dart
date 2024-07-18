import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:proklinik_models/models/user_model.dart';

class HxUserModel {
  const HxUserModel();

  Future<UserModel> createUserAccount(UserModel value) async {
    final result = await PocketbaseHelper.pb.collection("users").create(
          body: value.toPocketbaseJson(),
        );

    final model = UserModel.fromJson(result.toJson());
    return model;
  }

  Future<RecordAuth> loginUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    final result =
        await PocketbaseHelper.pb.collection("users").authWithPassword(
              email,
              password,
            );
    return result;
  }

  Future<UserModel> updateUserModel({
    required String id,
    required Map<String, dynamic> update,
  }) async {
    final result = await PocketbaseHelper.pb.collection("users").update(
          id,
          body: update,
        );

    final _user = UserModel.fromJson(result.toJson());
    return _user;
  }
}
