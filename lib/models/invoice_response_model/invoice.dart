import 'package:doctopia_doctors/models/app_constants_model/_models/invoice_status.dart';
import 'package:equatable/equatable.dart';

class Invoice extends Equatable {
  final String id;
  final String doc_id;
  final InvoiceStatus invoice_status;
  final String payment_link;
  final String payment_reference_number;
  final int month;
  final int year;
  final int amount;
  final int tax;
  final int total;
  final DateTime created;

  const Invoice({
    required this.id,
    required this.doc_id,
    required this.invoice_status,
    required this.payment_link,
    required this.payment_reference_number,
    required this.month,
    required this.year,
    required this.amount,
    required this.tax,
    required this.total,
    required this.created,
  });

  Invoice copyWith({
    String? id,
    String? doc_id,
    InvoiceStatus? invoice_status,
    String? payment_link,
    String? payment_reference_number,
    int? month,
    int? year,
    int? amount,
    int? tax,
    int? total,
    DateTime? created,
  }) {
    return Invoice(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      invoice_status: invoice_status ?? this.invoice_status,
      payment_link: payment_link ?? this.payment_link,
      payment_reference_number:
          payment_reference_number ?? this.payment_reference_number,
      month: month ?? this.month,
      year: year ?? this.year,
      amount: amount ?? this.amount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'invoice_status': invoice_status.toJson(),
      'payment_link': payment_link,
      'payment_reference_number': payment_reference_number,
      'month': month,
      'year': year,
      'amount': amount,
      'tax': tax,
      'total': total,
      'created': created.toIso8601String(),
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      invoice_status:
          InvoiceStatus.fromJson(map['invoice_status'] as Map<String, dynamic>),
      payment_link: map['payment_link'] as String,
      payment_reference_number: map['payment_reference_number'] as String,
      month: map['month'] as int,
      year: map['year'] as int,
      amount: map['amount'] as int,
      tax: map['tax'] as int,
      total: map['total'] as int,
      created: DateTime.parse(map['created'] as String),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      doc_id,
      invoice_status,
      payment_link,
      payment_reference_number,
      month,
      year,
      amount,
      tax,
      total,
      created,
    ];
  }
}
