import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:pocketbase/pocketbase.dart';

class DoctorFeedbackApi {
  final String docId;

  DoctorFeedbackApi({required this.docId});

  Future<void> sendDoctorFeedback({required String message}) async {
    try {
      await PocketbaseHelper.pb.collection('doctor_feedback').create(
        body: {
          'feedback': message,
          'doc_id': docId,
        },
      );
    } on ClientException catch (e) {
      throw Exception(e.response['message']);
    }
  }
}
