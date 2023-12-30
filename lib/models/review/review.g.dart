// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      docid: json['docid'] as String,
      username: json['username'] as String,
      body: json['body'] as String,
      stars: json['stars'] as int,
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'docid': instance.docid,
      'username': instance.username,
      'body': instance.body,
      'stars': instance.stars,
    };
