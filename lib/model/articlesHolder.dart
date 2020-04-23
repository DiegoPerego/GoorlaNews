import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:goorlanews/services/api.dart';

import 'article.dart';

class ArticlesHolder extends ChangeNotifier {
  ArticlesHolder() {
    Api().getHeadlines().then((value) => articles = value);
  }

  final List<Article> _articles = [];

  final Map<String, List<Article>> _articlesMap = Map();

  final Map<String, Article> _favArticles = Map();

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
    _favArticles.putIfAbsent(article.url, () => article);
    notifyListeners();
  }

  void removeArticleFromFav(Article article) {
    assert(article != null);
    assert(_favArticles.length != 0);
    _favArticles.remove(article.url);
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

  LinkedHashMap<String, Article> getFavouriteArticles() => _favArticles;

  List<Article> getSearchedArticles(String search) => _articlesSearchedMap;

  List<Article> get articles => _articles;
}
