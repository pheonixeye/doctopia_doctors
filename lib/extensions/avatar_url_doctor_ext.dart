import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/doctor_response_model/doctor.dart';

extension AvatarUrl on Doctor {
  String? get avatarUrl => avatar.isEmpty
      ? null
      : "${PocketbaseHelper.pb.baseURL}/api/files/doctors/$id/$avatar?thumb=200x200";
}
