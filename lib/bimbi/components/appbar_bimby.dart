import 'package:flutter/material.dart';

class AppBarBimby extends StatelessWidget {
  final String title;

  AppBarBimby(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
          height: 22,
          child: Image(
            image: AssetImage('images/bimby.png'),
            fit: BoxFit.fitHeight,
          )),
      Expanded(
        child: Container(),
      ),
      Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
      Expanded(
        child: Container(),
      ),
      Icon(
        Icons.person_pin,
        color: Colors.black,
      ),
      Icon(
        Icons.menu,
        color: Colors.black,
      )
    ]);
  }
}
