import 'package:doctopia_doctors/models/app_constants_model/_models/app_constant.dart';

class InvoiceStatus extends AppConstant {
  const InvoiceStatus({
    required super.id,
    required super.name_en,
    required super.name_ar,
  });

  factory InvoiceStatus.fromJson(Map<String, dynamic> map) {
    return InvoiceStatus(
      id: map['id'] as String,
      name_en: map['name_en'],
      name_ar: map['name_ar'],
    );
  }
}
