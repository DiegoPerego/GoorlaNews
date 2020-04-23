import 'package:flutter/material.dart';
import 'package:goorlanews/model/article.dart';
import 'package:share/share.dart';

class BottomSheetMenu extends StatelessWidget {
  final Article article;

  BottomSheetMenu(this.article, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      builder: (BuildContext context) {
        return Container(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.bookmark_border),
                    title: new Text('Salva per dopo',style: Theme.of(context).textTheme.headline2,),
                    onTap: () => {}),
                new ListTile(
                  leading: new Icon(Icons.share),
                  title: new Text('Condividi',style: Theme.of(context).textTheme.headline2,),
                  onTap: () => {
                    Share.share(
                        'Penso che questo articolo possa interessarti!\n${article.url}')
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
}
