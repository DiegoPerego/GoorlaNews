import 'package:flutter/material.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/utils/DateUtils.dart';

class NewsItem extends StatelessWidget {
  final Article article;

  NewsItem(this.article, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              child: article.urlToImage != null
                  ? Image(image: NetworkImage(article.urlToImage))
                  : Image(image: AssetImage('images/goorla_news.png')),
              borderRadius: BorderRadius.circular(20.0),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              article.source != null ? article.source : "",
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              article.title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              DateUtils.getArticleDate(article.publishedAt),
            )
          ],
        ));
    ;
  }
}
