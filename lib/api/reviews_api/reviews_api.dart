// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'package:doctopia_doctors/api/servers/servers.dart';
import 'package:doctopia_doctors/env/env.dart';
import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:doctopia_doctors/models/review/review.dart';

class HxReviews {
  final ENV env = ENV("dev");
  late final Server server;
  late final clientSDK.Databases client_db;

  HxReviews() {
    server = Server.main(env.env);
    client_db = clientSDK.Databases(server.clientAPI);
  }

  Future<List<({String id, Review review})>> fetchReviews(String doc_id) async {
    try {
      final response = await client_db.listDocuments(
        databaseId: env.creds.DATABASE_REVIEWS,
        collectionId: doc_id,
        queries: [
          clientSDK.Query.orderAsc('date'),
          //TODO: automate pagination for reviews
        ],
      );

      final reviews = response.documents.map((e) {
        return (id: e.$id, review: Review.fromJson(e.data));
      }).toList();

      return reviews;
    } catch (e) {
      rethrow;
    }
  }

  Future<({String id, Review review})> updateReview(
    String doc_id,
    String review_id,
    String reply,
  ) async {
    try {
      final res = await client_db.updateDocument(
        databaseId: env.creds.DATABASE_REVIEWS,
        collectionId: doc_id,
        documentId: review_id,
        data: {
          'doc_reply': reply,
        },
      );

      final review = (id: res.$id, review: Review.fromJson(res.data));
      return review;
    } catch (e) {
      rethrow;
    }
  }
}
