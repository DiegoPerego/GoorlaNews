import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goorlanews/components/snackbar.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/news_bloc.dart';
import 'package:goorlanews/services/db_repo.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  NewsDetail();

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _key = UniqueKey();
  bool isAddedToFav = false;
  Article article;

  final DbRepository _dbRepository = DbRepository();

  @override
  Widget build(BuildContext context) {
    _dbRepository.watch().forEach((element) {
      print("update");
    });

    final bloc = Provider.of<NewsBloc>(context, listen: false);
    article = bloc.selectedArticle;
    isAddedToFav = _dbRepository.containsArticle(article.id);

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

    final bloc = Provider.of<NewsBloc>(context, listen: false);
    bloc.addToFav(isAddedToFav);
    _scaffoldKey.currentState
        .showSnackBar(SnackbarArticle(isAddedToFav).build(context));  }
}
