import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:proklinik_models/models/invoice.dart';

extension PdfUrlOnInvoiceExt on Invoice {
  String get pdfUrl =>
      '${PocketbaseHelper.pb.baseUrl}/api/files/invoices_${month}_$year/$id/$file_reference';
}
