// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'article_meta.freezed.dart';
part 'article_meta.g.dart';

@freezed
class ArticleMeta with _$ArticleMeta {
  const factory ArticleMeta({
    required String id,
    required String docid,
    required String title_en,
    required String title_ar,
    required String description_en,
    required String description_ar,
    required String created_at,
    required String thumbnail,
    required String article_id,
  }) = _ArticleMeta;

  factory ArticleMeta.fromJson(Map<String, Object?> json) =>
      _$ArticleMetaFromJson(json);
}
