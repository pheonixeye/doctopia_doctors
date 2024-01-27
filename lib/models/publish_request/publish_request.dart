// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'publish_request.freezed.dart';
part 'publish_request.g.dart';

@freezed
class PublishRequest with _$PublishRequest {
  const factory PublishRequest({
    required int synd_id,
    required String name_en,
    required String name_ar,
    required bool published,
  }) = _PublishRequest;

  factory PublishRequest.fromJson(Map<String, Object?> json) =>
      _$PublishRequestFromJson(json);
}
