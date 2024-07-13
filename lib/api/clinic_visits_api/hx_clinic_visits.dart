// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

class HxClinicVisits {
  Future<List<ClinicVisit>?> fetchClinicVisits({
    required String doc_id,
    int? day,
    required int month,
    required int year,
  }) async {
    try {
      final response =
          await PocketbaseHelper.pb.collection("visits_${month}_$year").getList(
                filter:
                    "doc_id = '$doc_id'${(day == null || day == 0) ? "" : " && day = '$day'"}",
              );
      if (kDebugMode) {
        print(
            "HxClinicVisits($doc_id).fetchCinicVisits($day-$month-$year) # [${response.items.map((e) => e.data["user_name"]).toList()}]");
      }
      final visits =
          response.items.map((e) => ClinicVisit.fromJson(e.toJson())).toList();

      return visits;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  Future<ClinicVisit> updateClinicVisit({
    required String id,
    required int month,
    required int year,
    required bool attended,
  }) async {
    try {
      final response =
          await PocketbaseHelper.pb.collection("visits_${month}_$year").update(
        id,
        body: {
          "attended": attended,
        },
      );
      final visit = ClinicVisit.fromJson(response.toJson());
      return visit;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }
}
