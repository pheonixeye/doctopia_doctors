// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
      id: json['id'] as String,
      docid: json['docid'] as String,
      link: json['link'] as String,
      issued_at: json['issued_at'] as String,
      month: json['month'] as int,
      year: json['year'] as int,
      payment_reference: json['payment_reference'] as String,
      paid: json['paid'] as bool,
      amount: json['amount'] as int,
      tax: json['tax'] as int,
      total: (json['total'] as num).toDouble(),
      clinic_visits: (json['clinic_visits'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'docid': instance.docid,
      'link': instance.link,
      'issued_at': instance.issued_at,
      'month': instance.month,
      'year': instance.year,
      'payment_reference': instance.payment_reference,
      'paid': instance.paid,
      'amount': instance.amount,
      'tax': instance.tax,
      'total': instance.total,
      'clinic_visits': instance.clinic_visits,
    };
