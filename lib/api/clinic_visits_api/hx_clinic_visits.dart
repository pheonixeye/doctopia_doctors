// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
// import 'package:doctopia_doctors/functions/dprint.dart';
import 'package:doctopia_doctors/models/visit_response_model/visit.dart';
import 'package:pocketbase/pocketbase.dart';

class HxClinicVisits {
  const HxClinicVisits();

  static const String _expand = 'visit_type_id, visit_status_id';

  static const String collection = 'visits';

  Future<(int, List<Visit>)?> fetchClinicVisits({
    required String doc_id,
    required int page,
    required int perPage,
    int? day,
    int? month,
    int? year,
  }) async {
    try {
      final _yearFilter = year != null ? "&& year = '$year'" : "";
      final _monthFilter = month != null ? "&& month = '$month'" : "";
      final _dayFilter = day != null ? "&& day = '$day'" : "";
      final response = await PocketbaseHelper.pb.collection(collection).getList(
            page: page,
            perPage: perPage,
            filter: "doc_id = '$doc_id' $_yearFilter $_monthFilter $_dayFilter",
            expand: _expand,
            sort: '-created',
          );
      print(
          'HxClinicVisits($day / $month / $year, page: $page).fetchClinicVisits(total_items: ${response.totalItems}, total_pages: ${response.totalPages})');
      final visits = response.items
          .map((item) => Visit.fromJson({
                ...item.toJson(),
                'visit_type':
                    item.get<RecordModel>('expand.visit_type_id').toJson(),
                'visit_status':
                    item.get<RecordModel>('expand.visit_status_id').toJson(),
              }))
          .toList();

      return (response.totalItems, visits);
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  Future<Visit> updateClinicVisit({
    required String id,
    required Map<String, dynamic> update,
  }) async {
    try {
      final response = await PocketbaseHelper.pb.collection(collection).update(
            id,
            body: update,
            expand: _expand,
          );
      final visit = Visit.fromJson({
        ...response.toJson(),
        'visit_type':
            response.get<RecordModel>('expand.visit_type_id').toJson(),
        'visit_status':
            response.get<RecordModel>('expand.visit_status_id').toJson(),
      });
      return visit;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }
}
