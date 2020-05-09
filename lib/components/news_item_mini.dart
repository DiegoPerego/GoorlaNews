import 'package:flutter/material.dart';
import 'package:goorlanews/components/bottom_sheet.dart';
import 'package:goorlanews/components/news_item_image.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/news_bloc.dart';
import 'package:goorlanews/utils/DateUtils.dart';
import 'package:provider/provider.dart';

class NewsItemMini extends StatelessWidget {
  final Article article;

  NewsItemMini(this.article, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.65;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      article.source != null ? article.source : "",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    LimitedBox(
                      child: Text(
                        article.title
                            .substring(0, article.title.indexOf(" - ")),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      maxWidth: c_width,
                    ),
                  ]),
              NewsItemImage(
                article.urlToImage,
                radius: 20.0,
                mini: true,
              ),
            ],
          ),
          Column(children: <Widget>[
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
                  icon: Icon(Icons.more_vert, color: Colors.grey[500]),
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
            ),
          ]),
          SizedBox(
            height: 0.5,
            child: Container(
              color: Colors.grey[300],
            ),
          ),
        ]));
  }
}
