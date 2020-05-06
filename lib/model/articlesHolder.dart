import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:goorlanews/services/api.dart';

import 'article.dart';

class ArticlesHolder extends ChangeNotifier {
  ArticlesHolder() {
    Api().getArticles().then((value) => articles = value);
  }

  final List<Article> _articles = [];

  set articles(List<Article> news) {
    assert(news != null);
    _articles.clear;
    _articles.addAll(news);
    notifyListeners();
  }

  List<Article> get articles => _articles;
}
