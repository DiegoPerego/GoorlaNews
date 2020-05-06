import 'dart:async';

import 'package:goorlanews/services/api.dart';
import 'package:goorlanews/services/db_repo.dart';

import 'model/article.dart';

enum CategoriesEnum {
  general,
  business,
  entertainment,
  health,
  science,
  sports,
  technology
}

String categoryName(CategoriesEnum category) =>
    category.toString().split('.').last;

class NewsBloc {
  final Api _news = Api();
  CategoriesEnum _actualCategory = CategoriesEnum.general;

  Stream<List<Article>> get articles => _articles.stream;

  Stream<CategoriesEnum> get actualCategory => _screenController.stream;

  final DbRepository _dbRepository = DbRepository();

  Article _selectedArticle;

  Article get selectedArticle => _selectedArticle;

  set selectedArticle(Article value) {
    _selectedArticle = value;
  }

  final StreamController<CategoriesEnum> _screenController =
      StreamController<CategoriesEnum>.broadcast();
  final StreamController<List<Article>> _articles =
      StreamController<List<Article>>.broadcast();

  changeCategory(int index) {
    _actualCategory = CategoriesEnum.values[index];
    _articles.sink.add(null); //Clear news
    _screenController.sink.add(_actualCategory);
    getNews();
  }

  getNews() async {
    List<Article> response =
        await _news.getArticles(category: categoryName(_actualCategory));
    _articles.sink.add(response);
  }

  Future<bool> refresh(int index) async {
    _actualCategory = CategoriesEnum.values[index];
    _articles.sink.add(null); //Clear news
    getNews();
    return true;
  }

  void handleSearch(String search) async {
    List<Article> response = await _news.getArticles(search: search);
    _articles.sink.add(response);
  }

  void addToFav(bool isAddedToFav) {
    isAddedToFav
        ? _dbRepository.addArticle(_selectedArticle)
        : _dbRepository.removeArticle(_selectedArticle.id);
  }

  dispose() {
    _screenController?.close();
    _articles?.close();
  }

  NewsBloc() {}
}
