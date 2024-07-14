import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/med_article/med_article.dart';

class HxScrapper {
  Future<List<MedArticle>> init(int page) async {
    final response = await PocketbaseHelper.pb.collection("medscape").getList(
          page: page,
          perPage: 10,
        );

    final _articles =
        response.items.map((e) => MedArticle.fromJson(e.toJson())).toList();
    return _articles;
  }
}
