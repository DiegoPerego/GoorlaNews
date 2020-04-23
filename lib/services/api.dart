import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/model/articlesHolder.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const String API = "https://newsapi.org/v2/";
const String TOP_HEADLINES = "top-headlines";
const String TOKEN = "1454d540d8a747bda6da926d48534780";

class Api {
  Future<void> fetchArticles(
      {@required BuildContext context, String category}) async {
    var articlesHolder = Provider.of<ArticlesHolder>(context, listen: false);
    var client = http.Client();
    final response =
        await client.get(_buildUrl(TOP_HEADLINES, category: category));

    List<Article> news = await compute(_parseArticle, response.body);
    articlesHolder.addToArticlesMap(category, news);
  }

  Future<void> searchArticles(
      {@required BuildContext context, String search}) async {
    var articlesHolder = Provider.of<ArticlesHolder>(context, listen: false);
    var client = http.Client();
    final response = await client.get(_buildUrl(TOP_HEADLINES, search: search));

    List<Article> news = await compute(_parseArticle, response.body);
    articlesHolder.addToArticlesSearchedMap(news);
  }

  Future<List<Article>> getHeadlines() async {
    var client = http.Client();
    final response = await client.get(_buildUrl(TOP_HEADLINES));

    return await compute(_parseArticle, response.body);
  }

  static List<Article> _parseArticle(String responseBody) {
    final parsed = json.decode(responseBody);

    return parsed['articles']
        .map<Article>((json) => Article.fromJson(json))
        .toList();
  }

  String _buildUrl(String endpoint, {String category, String search}) {
    String url = '$API$endpoint?country=it';

    if (category != null) {
      url += '&category=$category';
    }

    if (search != null) {
      url += '&q=$search';
    }

    return '$url&apiKey=$TOKEN';
  }
}
