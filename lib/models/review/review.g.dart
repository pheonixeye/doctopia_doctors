// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      username: json['username'] as String,
      phone: json['phone'] as String,
      doc_reply: json['doc_reply'] as String,
      body: json['body'] as String,
      date: json['date'] as String,
      stars: json['stars'] as int,
      waiting_time: json['waiting_time'] as int,
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'username': instance.username,
      'phone': instance.phone,
      'body': instance.body,
      'stars': instance.stars,
      'waiting_time': instance.waiting_time,
      'doc_reply': instance.doc_reply,
    };
