// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:pocketbase/pocketbase.dart';

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:proklinik_models/models/booking_data.dart';
import 'package:proklinik_models/models/clinic.dart';
import 'package:proklinik_models/models/detailed_invoice.dart';
import 'package:proklinik_models/models/invoice.dart';

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

      List<({BookingData visit, Clinic clinic})> _records = [];

      for (int i = 0; i < _visits.length; i++) {
        _records.add((
          clinic: Clinic.fromJson(_clinics[i]),
          visit: BookingData.fromJson(_visits[i]),
        ));
      }

      final DetailedInvoice _parsed = DetailedInvoice(
        invoice: invoice,
        records: _records,
      );

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
