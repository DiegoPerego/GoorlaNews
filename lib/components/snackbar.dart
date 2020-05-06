import 'package:flutter/material.dart';

class SnackbarArticle extends StatelessWidget {
  final bool isAddedToFav;

  SnackbarArticle(this.isAddedToFav, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(isAddedToFav
          ? 'Notizia aggiunta in Segui'
          : 'Notizia rimossa da Segui'),
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 1000),
    );
  }
}
