import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:proklinik_models/models/doctor.dart';

extension AvatarUrl on Doctor {
  String? get avatarUrl => avatar == null
      ? null
      : "${PocketbaseHelper.pb.baseUrl}/api/files/doctors/$id/$avatar?thumb=200x200";
}
