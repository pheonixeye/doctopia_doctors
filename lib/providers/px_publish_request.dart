// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/publish_request_api/publish_request_api.dart';
import 'package:doctopia_doctors/models/publish_request/publish_request.dart';
import 'package:flutter/material.dart';

class PxPublishRequest extends ChangeNotifier {
  final HxPublishRequest publishRequestService;
  final String doc_id;

  PxPublishRequest({required this.doc_id, required this.publishRequestService});

  PublishRequest? _publishRequest;
  PublishRequest? get publishRequest => _publishRequest;

  Future<PublishRequest?> fetchPublishRequest() async {
    try {
      final response = await publishRequestService.fetchPublishRequest(doc_id);
      _publishRequest = response;
      notifyListeners();
      return _publishRequest;
    } catch (e) {
      rethrow;
    }
  }

  Future<PublishRequest> createPublishRequest({
    required int synd_id,
    required String name_en,
    required String name_ar,
    required bool published,
  }) async {
    try {
      final response = await publishRequestService.createPublishRequest(
        doc_id,
        PublishRequest(
          synd_id: synd_id,
          name_en: name_en,
          name_ar: name_ar,
          published: published,
        ),
      );

      _publishRequest = response;
      notifyListeners();
      return _publishRequest!;
    } catch (e) {
      rethrow;
    }
  }
}
