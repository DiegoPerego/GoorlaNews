import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:goorlanews/services/api.dart';

import 'article.dart';

class ArticlesHolder extends ChangeNotifier {
  ArticlesHolder({List<Article> favArticles}) {
    Api().getHeadlines().then((value) => articles = value);
  }

  final List<Article> _articles = [];

  final Map<String, List<Article>> _articlesMap = Map();

  final List<Article> favArticles = [];

  final List<Article> _articlesSearchedMap = [];

  Article _selectedArticle;

  Article get selectedArticle => _selectedArticle;

  set selectedArticle(Article value) {
    _selectedArticle = value;
  }

  set articles(List<Article> news) {
    assert(news != null);
    _articles.clear;
    _articles.addAll(news);
    notifyListeners();
  }

  void addToArticlesMap(String key, List<Article> news) {
    assert(news != null);
    _articlesMap[key] = news;
    notifyListeners();
  }

  void addArticleToFav(Article article) {
    assert(article != null);
    favArticles.add(article);
    notifyListeners();
  }

  void removeArticleFromFav(Article article) {
    assert(article != null);
    assert(favArticles.length != 0);
    favArticles.remove(article);
    notifyListeners();
  }

  void addToArticlesSearchedMap(List<Article> news) {
    assert(news != null);
    _articlesSearchedMap.clear();
    _articlesSearchedMap.addAll(news);
    notifyListeners();
  }

  void clearArticleSearched() {
    assert(_articlesSearchedMap != null);
    _articlesSearchedMap.clear();
  }

  List<Article> getArticles(String category) => _articlesMap[category];

  List<Article> getFavouriteArticles() => favArticles;

  List<Article> getSearchedArticles(String search) => _articlesSearchedMap;

  List<Article> get articles => _articles;

  factory ArticlesHolder.fromJson(List<dynamic> parsedJson) {
    List<Article> articles = List<Article>();
    articles = parsedJson.map((i) => Article.fromJson(i)).toList();

    return ArticlesHolder(
      favArticles: articles,
    );
  }

  List<Map> toJson() {
    List<Map> articles = favArticles.map((i) => i.toJson()).toList();

    return articles;
  }
}
