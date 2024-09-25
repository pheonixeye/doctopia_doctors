// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/invoices_api/invoices_api.dart';
import 'package:flutter/foundation.dart';
import 'package:proklinik_models/models/detailed_invoice.dart';

class PxInvoices extends ChangeNotifier {
  final HxInvoices invoicesService;
  final String doc_id;

  PxInvoices({
    required this.doc_id,
    required this.invoicesService,
  }) {
    fetchInvoice();
  }

  int _month = DateTime.now().month;
  int get month => _month;
  int _year = DateTime.now().year;
  int get year => _year;

  DetailedInvoice? _invoice;
  DetailedInvoice? get invoice => _invoice;

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
      if (kDebugMode) {
        print("PxInvoices().fetchInvoice()");
      }
      notifyListeners();
    } catch (e) {
      _invoice = null;
      notifyListeners();
      rethrow;
    }
  }
}
