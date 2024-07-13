import 'package:chaleno/chaleno.dart';
import 'package:doctopia_doctors/models/med_article/med_article.dart';
import 'package:uuid/uuid.dart';

class HxScrapper {
  Future<List<MedArticle>> init(int page) async {
    late final String url = "https://www.medscape.com/index/list_13470_$page";

    List<Result> _results = [];
    await Chaleno().load(url).then((p) {
      for (var i = 1; i < 21; i++) {
        final res = p?.querySelector("#archives > ul > li:nth-child($i)");
        if (res != null) {
          _results.add(res);
        }
      }
    });
    // print("${_results.map((e) => e.html).toList()}");
    final _articles = _results.map((e) {
      final url = e.querySelector("a")?.href;
      final title = e.querySelector(".title")?.innerHTML;
      final teaser = e.querySelector("span")?.text;
      final from = e.querySelector(".byline")?.text;

      return MedArticle(
          id: const Uuid().v4(),
          title: title ?? "",
          teaser: teaser ?? "",
          url: url ?? "",
          from: from ?? "");
    }).toList();

    // print("${_articles[3]}");
    return _articles;
  }
}
