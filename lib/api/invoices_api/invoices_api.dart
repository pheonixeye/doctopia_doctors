// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/models/invoice_response_model/invoice.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';

class HxInvoices {
  const HxInvoices();

  static const String collection = 'invoices';

  static const String _expand = 'invoice_status_id, payment_link_id';

  Future<Invoice?> fetchDoctorInvoice(
    String doc_id, {
    required int month,
    required int year,
  }) async {
    try {
      final response = await PocketbaseHelper.pb.collection(collection).getList(
            perPage: 1,
            page: 1,
            filter: "doc_id = '$doc_id' && month = '$month' && year = '$year'",
            expand: _expand,
          );
      if (response.totalItems == 0) {
        return null;
      }

      final invoice = Invoice.fromJson({
        ...response.items.first.toJson(),
        'invoice_status':
            response.items.first.get<RecordModel>('invoice_status_id').toJson(),
        'payment_link':
            response.items.first.get<RecordModel>('payment_link_id').toJson(),
      });

      return invoice;
    } on ClientException catch (e) {
      throw Exception(e.response['message']);
    }
  }
}
