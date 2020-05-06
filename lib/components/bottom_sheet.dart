import 'package:flutter/material.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/news_bloc.dart';
import 'package:goorlanews/services/db_repo.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class BottomSheetMenu extends StatefulWidget {
  BottomSheetMenu();

  @override
  _BottomSheetMenuState createState() => _BottomSheetMenuState();
}

class _BottomSheetMenuState extends State<BottomSheetMenu> {
  bool isAddedToFav = false;
  final DbRepository _dbRepository = DbRepository();

  @override
  Widget build(BuildContext context) {
    Article article;

    article = Provider.of<NewsBloc>(context, listen: false).selectedArticle;

    isAddedToFav = _dbRepository.containsArticle(article.id);

    return BottomSheet(
      builder: (BuildContext context) {
        return Container(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                    leading: isAddedToFav
                        ? new Icon(Icons.bookmark)
                        : new Icon(Icons.bookmark_border),
                    title: Text(
                      isAddedToFav
                          ? 'Rimuovi dalle notizie salvate'
                          : 'Salva per dopo',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    onTap: () => _handleOnPressed()),
                new ListTile(
                  leading: new Icon(Icons.share),
                  title: new Text(
                    'Condividi',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    Share.share(
                        'Penso che questo articolo possa interessarti!\n${article.url}');
                    close();
                  },
                ),
              ],
            ),
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0))),
          ),
          color: Color(0xFF737373),
        );
      },
      onClosing: () {},
    );
  }

  void _handleOnPressed() {
    setState(() {
      isAddedToFav = !isAddedToFav;
    });

    final bloc = Provider.of<NewsBloc>(context, listen: false);
    bloc.addToFav(isAddedToFav);
    close();
  }

  void close() {
    Navigator.of(context).pop();
  }
}
