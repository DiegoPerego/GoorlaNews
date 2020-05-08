import 'package:flutter/material.dart';
import 'file:///C:/Users/diegop/Desktop/diego/flutter%20corso/apps/goorla_news/lib/extra/ActionItemSimple.dart';

class Bimbi extends StatefulWidget {
  @override
  _BimbiState createState() => _BimbiState();
}

class _BimbiState extends State<Bimbi> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Bimbi",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: new Center(
        child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                child: OnSlideSimple(items: [
                  new ActionItemsSimple(
                      icon: new IconButton(
                        icon: new Icon(Icons.call),
                        onPressed: () {},
                        color: Colors.white,
                      ),
                      onPress: () {},
                      backgroudColor: Colors.green[500]),
                  new ActionItemsSimple(
                      icon: new IconButton(
                        icon: new Icon(Icons.email),
                        onPressed: () {},
                        color: Colors.white,
                      ),
                      onPress: () {},
                      backgroudColor: Colors.green[900])
                ], child: buildCard()));
          },
          itemCount: 10,
        ),
      ),
    );
  }

  Widget text(String up, String down) {
    return Column(
      children: <Widget>[
        Text(
          up,
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
        Text(
          down,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  firstRow() {
    return Padding(
        padding: EdgeInsets.all(8),
        child: new Row(
          children: <Widget>[
            new Icon(
              Icons.person_pin,
              color: Colors.green[800],
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Mario Rossi",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                Text("Via arcimabaldo 9000, 20137 Milano",
                    style: TextStyle(fontSize: 14))
              ],
            ),
            Expanded(
              child: Container(),
            ),
            new Icon(
              Icons.content_paste,
              color: Colors.green[800],
            )
          ],
        ));
  }

  buildCard() => new Container(
        width: 300.0,
        height: 150.0,
        child: new Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey[200],
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[800],
                  blurRadius: 5.0,
                  // has the effect of softening the shadow
                  spreadRadius: 2.0,
                  // has the effect of extending the shadow
                  offset: Offset(
                    2.0, // horizontal, move right 10
                    2.0, // vertical, move down 10
                  ),
                )
              ],
              borderRadius: new BorderRadius.all(const Radius.circular(0.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                firstRow(),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  color: Colors.grey[500],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text("Ult.mod.", "TM5"),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey[300],
                    ),
                    text("Ult.acquisto", "21.12.2020"),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey[300],
                    ),
                    text("Tipo ult. cont.", "Demo")
                  ],
                ),
                Expanded(
                    child: Container(
                        color: Colors.grey[100],
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Icon(
                              Icons.shopping_basket,
                              color: Colors.green[800],
                            ),
                            new Icon(
                              Icons.home,
                              color: Colors.grey[400],
                            ),
                            new Icon(
                              Icons.airport_shuttle,
                              color: Colors.green[800],
                            ),
                            new Icon(
                              Icons.airline_seat_flat,
                              color: Colors.green[800],
                            ),
                            new Icon(
                              Icons.perm_device_information,
                              color: Colors.grey[400],
                            ),
                            SizedBox(
                              width: 100,
                            )
                          ],
                        )))
              ],
            )),
      );
}
