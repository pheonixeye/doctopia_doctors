// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
import 'package:doctopia_doctors/models/invoice/invoice.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

class HxInvoices {
  Future<Invoice?> fetchDoctorInvoice(
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
      if (kDebugMode) {
        // print(response.toJson());
      }
      final invoice = Invoice.fromJson(response.items.first.toJson());
      //FIXME incorrect parsing of a large object

      // final invoiceVisits = response.items.map((e) {
      //   return ClinicVisit.fromJson(e.toJson()["expand"]['clinic_visits']);
      // }).toList();
      // if (kDebugMode) {
      //   print(invoiceVisits);
      // }
      // final invoiceClinics = response.items.map((e) {
      //   return Clinic.fromJson(
      //       e.toJson()['expand']['clinic_visits'][0]["clinic_id"]);
      // }).toList();
      // if (kDebugMode) {
      //   print(invoiceClinics);
      // }
      return invoice;
    } on ClientException catch (e) {
      throw Exception(e.response['message']);
    }
  }

  //TODO: pay invoice

  Future<Invoice?> payInvoice() async {}
}
