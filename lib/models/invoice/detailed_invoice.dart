import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
import 'package:doctopia_doctors/models/invoice/invoice.dart';

class DetailedInvoice {
  final Invoice invoice;
  final List<({ClinicVisit visit, Clinic clinic})> records;

  DetailedInvoice({
    required this.invoice,
    required this.records,
  });

  @override
  String toString() {
    return "${records.map((e) => "${e.clinic.name_en} => ${e.visit.user_name} @ ${e.visit.date_time}").toList()}";
  }
}
