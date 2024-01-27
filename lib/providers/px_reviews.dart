// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/reviews_api/reviews_api.dart';
import 'package:doctopia_doctors/models/review/review.dart';
import 'package:flutter/foundation.dart';

class PxReviews extends ChangeNotifier {
  final HxReviews reviewsService;

  PxReviews({required this.reviewsService});

  List<({String id, Review review})> _reviews = [];
  List<({String id, Review review})> get reviews => _reviews;

  Future<List<({String id, Review review})>> fetchReviews(String doc_id) async {
    try {
      final res = await reviewsService.fetchReviews(doc_id);
      _reviews = res;
      notifyListeners();
      return _reviews;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateReview(
      String doc_id, String review_id, String reply) async {
    await reviewsService.updateReview(doc_id, review_id, reply);
    await fetchReviews(doc_id);
  }
}
