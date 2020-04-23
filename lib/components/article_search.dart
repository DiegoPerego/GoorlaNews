import 'package:flutter/material.dart';
import 'package:goorlanews/components/news_item.dart';
import 'package:goorlanews/model/articlesHolder.dart';
import 'package:goorlanews/services/api.dart';
import 'package:goorlanews/themes/theme.dart';
import 'package:provider/provider.dart';

class ArticleSearch extends SearchDelegate<String> {
  ArticleSearch();

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [
      query.isNotEmpty
          ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                query = '';
                Provider.of<ArticlesHolder>(context, listen: false)
                    .clearArticleSearched();
              })
          : Container()
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    query.isNotEmpty ? _handleSearch(context, query) : null;

    return Consumer<ArticlesHolder>(builder: (context, holder, child) {
      return ListView.builder(
          itemCount: holder.getSearchedArticles(query) == null
              ? 0
              : holder.getSearchedArticles(query).length,
          itemBuilder: (context, position) =>
              NewsItem(holder.getSearchedArticles(query)[position], true));
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  String get searchFieldLabel => "Cerca argomenti, località e fonti";


  @override
  ThemeData appBarTheme(BuildContext context) {
    return searchAppTheme;
  }

  void _handleSearch(BuildContext context, String search) async {
    await Api().searchArticles(context: context, search: search);
  }
}
