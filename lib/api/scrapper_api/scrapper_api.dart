import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/medscape_response_model/med_article.dart';

class HxScrapper {
  const HxScrapper();

  static const String collection = 'medscape';

  Future<List<MedArticle>> init(int page) async {
    final response = await PocketbaseHelper.pb.collection(collection).getList(
          page: page,
          perPage: 10,
        );

    final _articles =
        response.items.map((e) => MedArticle.fromJson(e.toJson())).toList();
    return _articles;
  }
}
