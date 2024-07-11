// import 'package:doctopia_doctors/api/documents_api/hx_documents.dart';
// import 'package:doctopia_doctors/models/documents/documents.dart';
// import 'package:flutter/material.dart';

// class PxDocuments extends ChangeNotifier {
//   final HxDocuments documentsService;

//   PxDocuments({
//     required this.documentsService,
//   });

//   DoctorDocuments? _doctorDocuments;
//   DoctorDocuments? get doctorDocuments => _doctorDocuments;

//   Future<void> initDocuments(String docid) async {
//     try {
//       final res = await documentsService.fetchDoctorDocuments(docid);
//       _doctorDocuments = res;
//       notifyListeners();
//       // print(_doctorDocuments?.toJson().toString());
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<String> _uploadImage(String path, String fileName) async {
//     try {
//       final imgId = await documentsService.uploadImage(path, fileName);
//       return imgId;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> updateDocument(String key, String path, String docid,
//       {required String fileName}) async {
//     final imgId = await _uploadImage(path, fileName);
//     try {
//       final result = await documentsService.updateDoctorDocuments(
//         docid: docid,
//         update: {key: imgId},
//       );

//       _doctorDocuments = result;
//       notifyListeners();
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
