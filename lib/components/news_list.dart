import 'package:flutter/material.dart';
import 'package:goorlanews/model/article.dart';
import 'package:provider/provider.dart';

import '../news_bloc.dart';
import 'news_item.dart';

class NewsList extends StatelessWidget {
  final bool isMini;

  NewsList(this.isMini);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<NewsBloc>(context, listen: false);
    return StreamBuilder<List<Article>>(
        stream: bloc.articles,
        builder: (context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, position) =>
                    NewsItem(snapshot.data[position], isMini));
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}
