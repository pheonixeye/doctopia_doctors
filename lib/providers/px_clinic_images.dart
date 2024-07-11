// // ignore_for_file: non_constant_identifier_names

// import 'package:doctopia_doctors/api/clinic_images_api/clinic_images_api.dart';
// import 'package:doctopia_doctors/models/clinic_images/clinic_images.dart';
// import 'package:flutter/material.dart';

// class PxClinicImages extends ChangeNotifier {
//   final HxClinicImages clinicImagesService;

//   PxClinicImages({required this.clinicImagesService});

//   ClinicImages? _images;
//   ClinicImages? get images => _images;

//   Future<ClinicImages> fetchClinicImages(String clinic_id) async {
//     try {
//       final response =
//           await clinicImagesService.fetchClinicImagesIds(clinic_id);
//       _images = response;
//       notifyListeners();
//       return _images!;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<String> _uploadImage(String path, String fileName) async {
//     try {
//       final imgId = await clinicImagesService.uploadImage(path, fileName);
//       return imgId;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<String> _deleteImage(String id) async {
//     try {
//       final imgId = await clinicImagesService.deleteImage(id);
//       return imgId;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<ClinicImages> addClinicImage(String path, String clinic_id,
//       {required String fileName}) async {
//     final imgId = await _uploadImage(path, fileName);
//     try {
//       final result = await clinicImagesService.updateClinicImageIds(
//         clinic_id: clinic_id,
//         images: [..._images!.images, imgId],
//       );
//       _images = result;
//       notifyListeners();
//       return _images!;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<ClinicImages> deleteClinicImage(String id, String clinic_id) async {
//     final imgId = await _deleteImage(id);
//     final List<String> _updated = [..._images!.images]..remove(imgId);
//     try {
//       final result = await clinicImagesService.updateClinicImageIds(
//         clinic_id: clinic_id,
//         images: _updated,
//       );
//       _images = result;
//       notifyListeners();
//       return _images!;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
