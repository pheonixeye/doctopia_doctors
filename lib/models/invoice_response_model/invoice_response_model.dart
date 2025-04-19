import 'package:equatable/equatable.dart';

class InvoiceResponseModel extends Equatable {
  final String id;
  final String doc_id;
  final String invoice_status_id;
  final String payment_link_id;
  final int month;
  final int year;
  final int amount;
  final int tax;
  final int total;
  final String payment_reference_number;
  final String created;

  const InvoiceResponseModel({
    required this.id,
    required this.doc_id,
    required this.invoice_status_id,
    required this.payment_link_id,
    required this.month,
    required this.year,
    required this.amount,
    required this.tax,
    required this.total,
    required this.payment_reference_number,
    required this.created,
  });

  InvoiceResponseModel copyWith({
    String? id,
    String? doc_id,
    String? invoice_status_id,
    String? payment_link_id,
    int? month,
    int? year,
    int? amount,
    int? tax,
    int? total,
    String? payment_reference_number,
    String? created,
  }) {
    return InvoiceResponseModel(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      invoice_status_id: invoice_status_id ?? this.invoice_status_id,
      payment_link_id: payment_link_id ?? this.payment_link_id,
      month: month ?? this.month,
      year: year ?? this.year,
      amount: amount ?? this.amount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      payment_reference_number:
          payment_reference_number ?? this.payment_reference_number,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'invoice_status_id': invoice_status_id,
      'payment_link_id': payment_link_id,
      'month': month,
      'year': year,
      'amount': amount,
      'tax': tax,
      'total': total,
      'payment_reference_number': payment_reference_number,
      'created': created,
    };
  }

  factory InvoiceResponseModel.fromJson(Map<String, dynamic> map) {
    return InvoiceResponseModel(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      invoice_status_id: map['invoice_status_id'] as String,
      payment_link_id: map['payment_link_id'] as String,
      month: map['month'] as int,
      year: map['year'] as int,
      amount: map['amount'] as int,
      tax: map['tax'] as int,
      total: map['total'] as int,
      created: map['created'] as String,
      payment_reference_number: map['payment_reference_number'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      doc_id,
      invoice_status_id,
      payment_link_id,
      month,
      year,
      amount,
      tax,
      total,
      created,
      payment_reference_number,
    ];
  }
}
