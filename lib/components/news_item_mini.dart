import 'package:flutter/material.dart';
import 'package:goorlanews/components/bottom_sheet.dart';
import 'package:goorlanews/components/news_item_image.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/utils/DateUtils.dart';

class NewsItemMini extends StatelessWidget {
  final Article article;

  NewsItemMini(this.article, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.5;
    double i_width = MediaQuery.of(context).size.width * 0.3;
    double i_height = MediaQuery.of(context).size.width * 0.3;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      article.source != null ? article.source : "",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: Text(
                        article.title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      width: c_width,
                    ),
                  ]),
              NewsItemImage(
                article.urlToImage,
                radius: 20.0,
                height: i_height,
                width: i_width,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Column(children: <Widget>[
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
            ),
          ]),
        ]));
  }
}
