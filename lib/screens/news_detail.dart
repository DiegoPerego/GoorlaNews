import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/model/articlesHolder.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  NewsDetail();

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    Article article =
        Provider.of<ArticlesHolder>(context, listen: false).selectedArticle;

    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Goorla News",
            style: Theme.of(context).textTheme.title,
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: article.url,
            ))
          ],
        ));
  }
}
