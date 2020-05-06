import 'package:flutter/material.dart';
import 'package:goorlanews/components/news_item.dart';
import 'package:goorlanews/components/news_list.dart';
import 'package:goorlanews/model/articlesHolder.dart';
import 'package:goorlanews/services/api.dart';
import 'package:goorlanews/themes/theme.dart';
import 'package:provider/provider.dart';

import '../news_bloc.dart';

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
    final bloc = Provider.of<NewsBloc>(context, listen: false);
    // show some result based on the selection
    query.isNotEmpty ? bloc.handleSearch(query) : null;

    return Center(
      child: NewsList(true),
    );
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
}
