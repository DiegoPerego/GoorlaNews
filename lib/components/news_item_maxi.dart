import 'package:flutter/material.dart';
import 'package:goorlanews/components/bottom_sheet.dart';
import 'package:goorlanews/components/news_item_image.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/utils/DateUtils.dart';
import 'package:provider/provider.dart';

import '../news_bloc.dart';

class NewsItemMaxi extends StatelessWidget {
  final Article article;

  NewsItemMaxi(this.article, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              article.title.substring(0, article.title.indexOf(" - ")),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    DateUtils.getArticleDate(article.publishedAt),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext bc) {
                          Provider.of<NewsBloc>(context, listen: false)
                              .selectedArticle = article;
                          return BottomSheetMenu();
                        });
                  },
                )
              ],
            )
          ],
        ));
  }
}
