// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/models/invoice/detailed_invoice.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
import 'package:doctopia_doctors/models/invoice/invoice.dart';

class HxInvoices {
  Future<DetailedInvoice?> fetchDoctorInvoice(
    String doc_id,
    int month,
    int year,
  ) async {
    try {
      final response = await PocketbaseHelper.pb
          .collection("invoices_${month}_$year")
          .getList(
            filter: "doc_id = '$doc_id'",
            expand: "clinic_visits.clinic_id", //correct query
          );

      final invoice = Invoice.fromJson(response.items.first.toJson());

      final _item = response.items.first;
      final _json = _item.toJson();
      final _visits = _json['expand']["clinic_visits"];
      final _clinics = _visits.map((e) => e['expand']['clinic_id']).toList();

      List<({ClinicVisit visit, Clinic clinic})> _records = [];

      for (int i = 0; i < _visits.length; i++) {
        _records.add((
          clinic: Clinic.fromJson(_clinics[i]),
          visit: ClinicVisit.fromJson(_visits[i]),
        ));
      }

      final DetailedInvoice _parsed = DetailedInvoice(
        invoice: invoice,
        records: _records,
      );
      if (kDebugMode) {
        print(_parsed.toString());
      }
      return _parsed;
    } on ClientException catch (e) {
      throw Exception(e.response['message']);
    }
  }

  //TODO: pay invoice

  Future<Invoice?> payInvoice() async {
    return null;
  }
}
