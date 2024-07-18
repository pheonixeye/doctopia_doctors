import 'package:doctopia_doctors/api/scrapper_api/scrapper_api.dart';
import 'package:flutter/foundation.dart';
import 'package:proklinik_models/models/med_article.dart';

class PxScrapper extends ChangeNotifier {
  final HxScrapper scrapperService;

  PxScrapper({required this.scrapperService, required this.page}) {
    init();
  }

  List<MedArticle>? _pageResults;
  List<MedArticle>? get pageResults => _pageResults;

  final int page;

  Future<void> init() async {
    try {
      _pageResults = await scrapperService.init(page);
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
    if (kDebugMode) {
      print("PxScrapper().init(page:$page)");
    }
  }
}
