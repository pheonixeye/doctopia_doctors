// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/review/review.dart';
import 'package:pocketbase/pocketbase.dart';

class HxReviews {
  Future<List<Review>> fetchReviews(String id) async {
    try {
      final response = await PocketbaseHelper.pb
          .collection("reviews")
          .getList(filter: "doc_id = '$id'");
      final reviews =
          response.items.map((e) => Review.fromJson(e.toJson())).toList();
      return reviews;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }
}
