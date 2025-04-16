import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/functions/dprint.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/site_service.dart';
import 'package:doctopia_doctors/models/user_model_response.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:proklinik_models/models/user_model.dart';

class HxUserModel {
  const HxUserModel();

  static const String _expand = 'service_id';

  Future<UserModelResponse> createUserAccount(UserModel value) async {
    final result = await PocketbaseHelper.pb.collection("users").create(
      body: {
        ...value.toPocketbaseJson(),
      },
      expand: _expand,
    );

    final model = UserModel.fromJson(result.toJson());
    final siteService = SiteService.fromJson(
        result.get<RecordModel>('expand.$_expand').toJson());
    return UserModelResponse(
      userModel: model,
      siteService: siteService,
      token: result.toJson()['token'],
    );
  }

  Future<UserModelResponse> loginUserByPassword(
    String syndIdOrEmail,
    String password,
  ) async {
    final result =
        await PocketbaseHelper.pb.collection("users").authWithPassword(
              syndIdOrEmail,
              password,
              expand: _expand,
            );

    dprint(
        'UserModelApi().loginUserByPassword(lib/api/user_model_api/user_model_api.dart:42)');
    dprint(result);
    final model = UserModel.fromJson(result.record.toJson());
    final siteService = SiteService.fromJson(
        result.record.get<RecordModel>('expand.$_expand').toJson());
    final _userModelResponse = UserModelResponse(
      userModel: model,
      siteService: siteService,
      token: result.toJson()['token'],
    );
    return _userModelResponse;
  }

  Future<UserModelResponse> updateUserModel({
    required String id,
    required Map<String, dynamic> update,
  }) async {
    final result = await PocketbaseHelper.pb.collection("users").update(
          id,
          body: update,
          expand: _expand,
        );
    final model = UserModel.fromJson(result.toJson());

    final siteService = SiteService.fromJson(
        result.get<RecordModel>('expand.$_expand').toJson());
    return UserModelResponse(
      userModel: model,
      siteService: siteService,
      token: result.toJson()['token'],
    );
  }
}
