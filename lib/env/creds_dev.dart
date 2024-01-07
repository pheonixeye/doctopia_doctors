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
  //-------------------------------------------------------------------//
}
