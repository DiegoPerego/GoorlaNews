import 'package:flutter/material.dart';
import 'package:goorlanews/components/news_item_image.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/model/articlesHolder.dart';
import 'package:goorlanews/utils/DateUtils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class NewsItemMini extends StatelessWidget {
  final Article article;

  NewsItemMini(this.article, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  article.source != null ? article.source : "",
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                    child: Text(
                  article.title,
                  style: Theme.of(context).textTheme.subtitle1,
                )),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  DateUtils.getArticleDate(article.publishedAt),
                )
              ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
            Container(
                height: 100,
                width: 100,
                child: NewsItemImage(
                  article.urlToImage,
                  radius: 20.0,
                )),
            const SizedBox(
              height: 30,
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ])
        ]));
  }
}
