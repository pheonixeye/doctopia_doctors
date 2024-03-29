// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/invoices_api/invoices_api.dart';
import 'package:doctopia_doctors/models/invoice/invoice.dart';
import 'package:flutter/material.dart';

class PxInvoices extends ChangeNotifier {
  final HxInvoices invoicesService;
  final String doc_id;

  PxInvoices({required this.doc_id, required this.invoicesService});

  int _month = DateTime.now().month;
  int get month => _month;
  int _year = DateTime.now().year;
  int get year => _year;

  ({String id, Invoice invoice})? _invoice;
  ({String id, Invoice invoice})? get invoice => _invoice;

  Future<void> setDate({int? m, int? y}) async {
    _month = m ?? _month;
    _year = y ?? _year;
    notifyListeners();
    await fetchInvoice();
  }

  Future<void> fetchInvoice() async {
    try {
      final response =
          await invoicesService.fetchDoctorInvoice(doc_id, month, year);
      _invoice = response;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
