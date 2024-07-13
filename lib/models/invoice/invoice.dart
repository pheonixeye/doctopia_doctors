// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:equatable/equatable.dart';

class Invoice extends Equatable {
  final String id;
  final String doc_id;
  final String issued_at;
  final int month;
  final int year;
  final String payment_link;
  final String payment_reference;
  final String file_reference;
  final bool paid;
  final double amount;
  final double tax;
  final double total;
  final List<String> clinic_visits;

  const Invoice({
    required this.id,
    required this.doc_id,
    required this.issued_at,
    required this.month,
    required this.year,
    required this.payment_link,
    required this.payment_reference,
    required this.file_reference,
    required this.paid,
    required this.amount,
    required this.tax,
    required this.total,
    required this.clinic_visits,
  });

  Invoice copyWith({
    String? id,
    String? doc_id,
    String? issued_at,
    int? month,
    int? year,
    String? payment_link,
    String? payment_reference,
    String? file_reference,
    bool? paid,
    double? amount,
    double? tax,
    double? total,
    List<String>? clinic_visits,
  }) {
    return Invoice(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      issued_at: issued_at ?? this.issued_at,
      month: month ?? this.month,
      year: year ?? this.year,
      payment_link: payment_link ?? this.payment_link,
      payment_reference: payment_reference ?? this.payment_reference,
      file_reference: file_reference ?? this.file_reference,
      paid: paid ?? this.paid,
      amount: amount ?? this.amount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      clinic_visits: clinic_visits ?? this.clinic_visits,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'issued_at': issued_at,
      'month': month,
      'year': year,
      'payment_link': payment_link,
      'payment_reference': payment_reference,
      'file_reference': file_reference,
      'paid': paid,
      'amount': amount,
      'tax': tax,
      'total': total,
      'clinic_visits': clinic_visits,
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      issued_at: map['issued_at'] as String,
      month: map['month'] as int,
      year: map['year'] as int,
      payment_link: map['payment_link'] as String,
      payment_reference: map['payment_reference'] as String,
      file_reference: map['file_reference'] as String,
      paid: map['paid'] as bool,
      amount: map['amount'] as double,
      tax: map['tax'] as double,
      total: map['total'] as double,
      clinic_visits: List<String>.from((map['clinic_visits'] as List<dynamic>)),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      doc_id,
      issued_at,
      month,
      year,
      payment_link,
      payment_reference,
      file_reference,
      paid,
      amount,
      tax,
      total,
      clinic_visits,
    ];
  }
  //http://127.0.0.1:8090/api/files/COLLECTION_ID_OR_NAME/RECORD_ID/FILENAME?thumb=100x300

  String get pdfUrl =>
      '${PocketbaseHelper.pb.baseUrl}/api/files/invoices_${month}_$year/$id/$file_reference';
}
