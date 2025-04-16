// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:doctopia_doctors/models/app_constants_model/_models/site_service.dart';
import 'package:equatable/equatable.dart';
import 'package:proklinik_models/proklinik_models.dart';

class UserModelResponse extends Equatable {
  final UserModel userModel;
  final SiteService siteService;
  final String? token;

  const UserModelResponse({
    required this.userModel,
    required this.siteService,
    required this.token,
  });

  @override
  List<Object?> get props => [
        userModel,
        siteService,
        token,
      ];

  @override
  bool? get stringify => true;
}
