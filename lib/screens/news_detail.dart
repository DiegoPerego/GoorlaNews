import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/model/articlesHolder.dart';
import 'package:goorlanews/shared_preferences/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  NewsDetail();

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  SharedPref sharedPref = SharedPref();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _key = UniqueKey();
  bool isAddedToFav = false;
  Article article;

  @override
  Widget build(BuildContext context) {
    article =
        Provider.of<ArticlesHolder>(context, listen: false).selectedArticle;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
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
        ),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share(
                      'Penso che questo articolo possa interessarti!\n${article.url}');
                }),
            IconButton(
                icon: isAddedToFav
                    ? Icon(Icons.bookmark)
                    : Icon(Icons.bookmark_border),
                onPressed: _handleOnPressed)
          ],
        )));
  }

  void _handleOnPressed() {
    setState(() {
      isAddedToFav = !isAddedToFav;
    });

    if (isAddedToFav) {
      Provider.of<ArticlesHolder>(context, listen: false).addArticleToFav(
          Provider.of<ArticlesHolder>(context, listen: false).selectedArticle);
      sharedPref.save(
          "FAVOURITE",
          Provider.of<ArticlesHolder>(context, listen: false)
              .getFavouriteArticles());
    }

    SnackBar _snackBar = isAddedToFav
        ? showSnackbar('Notizia aggiunta in Segui')
        : showSnackbar('Notizia rimossa da Segui');
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  }

  SnackBar showSnackbar(String text) {
    return SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 1000),
    );
  }
}
