// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/reviews_api/reviews_api.dart';
import 'package:doctopia_doctors/models/review_response_model/review.dart';
import 'package:flutter/foundation.dart';

class PxReviews extends ChangeNotifier {
  final HxReviews reviewsService;
  final String doc_id;
  PxReviews({
    required this.doc_id,
    required this.reviewsService,
  }) {
    _fetchReviews();
  }

  static List<Review>? _reviews;
  List<Review>? get reviews => _reviews;

  static List<Review> _lastFetchResult = [];

  static int _page = 1;
  int get page => _page;

  static const int _perPage = 5;

  static bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> _fetchReviews() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await reviewsService.fetchReviews(
        doc_id: doc_id,
        page: page,
        perPage: _perPage,
      );
      _lastFetchResult = response;
      _reviews ??= [];
      _reviews!.addAll(response);
      notifyListeners();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchMoreReviews() async {
    if (_reviews != null && _lastFetchResult.length < _perPage) {
      return;
    }
    print('PxReviews().fetchMoreReviews($_page)');
    _page++;
    notifyListeners();
    await _fetchReviews();
  }
}
