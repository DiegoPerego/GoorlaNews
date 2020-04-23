import 'package:flutter/material.dart';
import 'package:goorlanews/components/bottom_sheet.dart';
import 'package:goorlanews/components/news_item_image.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/utils/DateUtils.dart';

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
              article.title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateUtils.getArticleDate(article.publishedAt),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext bc) {
                          return BottomSheetMenu(article);
                        });
                  },
                )
              ],
            )
          ],
        ));
  }
}
