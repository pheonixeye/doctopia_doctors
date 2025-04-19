import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/speciality.dart';

extension SvgImage on Speciality {
  String get svgImage => image.isEmpty
      ? ''
      : "${PocketbaseHelper.pb.baseURL}/api/files/specialities/$id/$image?thumb=200x200";
}
