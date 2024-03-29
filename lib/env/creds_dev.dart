// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:doctopia_doctors/env/creds.dart';

class CREDSDEV implements CREDS {
  @override
  String ENDPOINT = 'http://localhost:4567/v1';
  //-------------------------------------------------------------------//
  @override
  String PROJECT = '65971012f07082d8ab5b';
  //-------------------------------------------------------------------//
  //FORMAT(DATABASE_DATABASE-NAME)
  @override
  String DATABASE_CONSTANTS = '659712fb491b78a6a3eb';
  //-------------------------------------------------------------------//
  //FORMAT(COLLECTION_COLLECTION-NAME_DATABASE-NAME)
  @override
  String COLLECTION_SPECIALITIES_CONSTANTS = "6597143473d5a3144e13";
  //-------------------------------------------------------------------//
  //-------------------------------------------------------------------//
  @override
  String API_KEY =
      '48496acdfd3010e4f526a886d288cf33fa4352d9368d58e4128c62547a4543b6aeb733f01b446ed9c48243a10e6102f8f42a78508c18520da1837bd6e2be8749a8d2d27937113da0c04952d0a44ae5108ffd505888b33fe6277697534e1cec65160299c2d2343c7b693289668afd270712ddffede50be992c2e8fc19c3e7872b';

  @override
  String get COLLECTION_DOCTORS_DOCTORS => "65993582811a4a88e828";

  @override
  String get DATABASE_DOCTORS => "6597130537d821724e3a";

  @override
  String get DATABASE_VISITS => "659713211fa0c2f1c721";

  @override
  String get COLLECTION_DOCTOR_DOCUMENTS_DOCTORS => "659935a2bb3a2310dc78";

  @override
  String get CREATE_DOCTOR_FUNCTION => '65a03e872b8af9cb6fcb';

  @override
  String get BUCKET_DOCTOR_DOCUMENTS => '65992beb48b126c6dca1';

  @override
  String get COLLECTION_GOVERNORATES_CONSTANTS => "65971420ddeab946eabd";

  @override
  String get COLLECTION_CITIES_CONSTANTS => "6597142a156512c1b5fa";

  @override
  String get COLLECTION_CLINICS_CLINICS => "659c20de23dc45c0bd70";

  @override
  String get DATABASE_CLINICS => "6597130e75340bbe78b5";

  @override
  String get BUCKET_CLINIC_IMAGES => '65992c6656ce010787a4';

  @override
  String get COLLECTION_CLINIC_IMAGES_CLINICS => '659c24521229d550da0c';

  @override
  String get DATABASE_SCHEDULE => '65a99357d692e8a7f7a8';

  @override
  String get COLLECTION_DOCTOR_DOCTOR_PUBLISH_REQUESTS =>
      "65a2f56554e758567727";

  @override
  String get DATABASE_REVIEWS => '65971337ddbd72bf356b';

  @override
  String get DATABASE_INVOICES => "6597132aa5c49a3ad6ad";

  //-------------------------------------------------------------------//
}
