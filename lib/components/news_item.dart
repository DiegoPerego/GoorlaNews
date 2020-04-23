import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:goorlanews/components/news_item_maxi.dart';
import 'package:goorlanews/components/news_item_mini.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/model/articlesHolder.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatelessWidget {
  final Article article;
  final bool isMini;

  NewsItem(this.article, this.isMini, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          kIsWeb ? _launchURL(article.url) : _launchNewsDetail(context);
        },
        child: isMini ? NewsItemMini(article) : NewsItemMaxi(article));
  }

  _launchNewsDetail(BuildContext context) {
    Provider.of<ArticlesHolder>(context, listen: false).selectedArticle =
        article;
    Navigator.pushNamed(context, '/newsDetail');
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
