// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/reviews_api/reviews_api.dart';
import 'package:doctopia_doctors/models/review/review.dart';
import 'package:flutter/foundation.dart';

class PxReviews extends ChangeNotifier {
  final HxReviews reviewsService;
  final String id;
  PxReviews({required this.id, required this.reviewsService}) {
    fetchReviews();
  }

  List<Review> _reviews = [];
  List<Review> get reviews => _reviews;

  Future<List<Review>> fetchReviews() async {
    try {
      final res = await reviewsService.fetchReviews(id);
      _reviews = res;
      notifyListeners();
      if (kDebugMode) {
        print("PxReviews().fetchReviews(No Of Reviews : ${_reviews.length})");
      }
      return _reviews;
    } catch (e) {
      rethrow;
    }
  }
}
