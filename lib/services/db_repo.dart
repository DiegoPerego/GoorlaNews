import 'package:goorlanews/model/article.dart';
import 'package:hive/hive.dart';

import '../main.dart';

class DbRepository {
  Box<Article> favouritesNews = Hive.box(NewsBox);

  addArticle(Article article) => favouritesNews.put(article.id, article);

  removeArticle(String id) => favouritesNews.delete(id);

  containsArticle(String id) => favouritesNews.containsKey(id);

  List<Article> getArticles() => favouritesNews.values.toList();

  watch() => favouritesNews.watch();
}
