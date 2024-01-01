// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'documents.freezed.dart';
part 'documents.g.dart';

@freezed
class Documents with _$Documents {
  const factory Documents({
    required String docid,
    required String synd_card,
    required String permit_cert,
    required String specialist_cert,
    required String consultant_cert,
    required String avatar,
  }) = _Documents;

  factory Documents.fromJson(Map<String, Object?> json) =>
      _$DocumentsFromJson(json);
}
