// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/review_response_model/review.dart';
import 'package:pocketbase/pocketbase.dart';

class HxReviews {
  const HxReviews();

  static const String collection = 'reviews';

  static const String _expand = 'review_status_id';

  Future<List<Review>> fetchReviews({
    required String doc_id,
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await PocketbaseHelper.pb.collection("reviews").getList(
            page: page,
            perPage: perPage,
            filter: "doc_id = '$doc_id'",
            expand: _expand,
            sort: '-created',
          );

      final reviews = response.items
          .map((item) => Review.fromJson({
                ...item.toJson(),
                'review_status':
                    item.get<RecordModel>('expand.review_status_id').toJson(),
              }))
          .toList();
      return reviews;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }
}
