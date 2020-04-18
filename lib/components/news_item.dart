import 'package:flutter/material.dart';
import 'package:goorlanews/components/news_item_image.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/model/articlesHolder.dart';
import 'package:goorlanews/utils/DateUtils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatelessWidget {
  final Article article;

  NewsItem(this.article, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          kIsWeb
              ? _launchURL(article.url)
              : Provider.of<ArticlesHolder>(context, listen: false)
                  .selectedArticle = article;
          Navigator.pushNamed(context, '/newsDetail');
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                NewsItemImage(
                  article.urlToImage,
                  radius: 20.0,
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
            )));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
