// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';
import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:doctopia_doctors/models/invoice/invoice.dart';

class HxInvoices {
  final ENV env;
  late final Server server;
  late final clientSDK.Databases client_db;

  HxInvoices({required this.env}) {
    server = Server.main(env.env);
    client_db = clientSDK.Databases(server.clientAPI);
  }

  Future<({String id, Invoice invoice})?> fetchDoctorInvoice(
      String doc_id, int month, int year) async {
    try {
      final response = await client_db.listDocuments(
        databaseId: env.creds.DATABASE_INVOICES,
        collectionId: doc_id,
        queries: [
          clientSDK.Query.equal('month', month),
          clientSDK.Query.equal('year', year),
        ],
      );

      if (response.documents.isEmpty) {
        return null;
      }

      final invoice = (
        id: response.documents.first.$id,
        invoice: Invoice.fromJson(response.documents.first.data)
      );
      return invoice;
    } catch (e) {
      rethrow;
    }
  }
}
