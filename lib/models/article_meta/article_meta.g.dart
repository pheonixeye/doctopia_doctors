// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleMetaImpl _$$ArticleMetaImplFromJson(Map<String, dynamic> json) =>
    _$ArticleMetaImpl(
      id: json['id'] as String,
      docid: json['docid'] as String,
      title_en: json['title_en'] as String,
      title_ar: json['title_ar'] as String,
      description_en: json['description_en'] as String,
      description_ar: json['description_ar'] as String,
      created_at: json['created_at'] as String,
      thumbnail: json['thumbnail'] as String,
      article_id: json['article_id'] as String,
    );

Map<String, dynamic> _$$ArticleMetaImplToJson(_$ArticleMetaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'docid': instance.docid,
      'title_en': instance.title_en,
      'title_ar': instance.title_ar,
      'description_en': instance.description_en,
      'description_ar': instance.description_ar,
      'created_at': instance.created_at,
      'thumbnail': instance.thumbnail,
      'article_id': instance.article_id,
    };
