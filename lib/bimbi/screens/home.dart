import 'package:flutter/material.dart';
import 'package:goorlanews/bimbi/components/appbar_bimby.dart';
import 'package:goorlanews/bimbi/components/container_bimby.dart';

import '../bimbi_icons.dart';

class Home extends StatefulWidget {
  Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var bottomHeigth = 40.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: AppBarBimby("Home")),
        body: Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey[300],
          child: Column(
            children: <Widget>[
              ContainerBimby(
                Row(
                  children: <Widget>[
                    Text(
                      "Ciao",
                      style: TextStyle(fontSize: 28),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Pippo",
                      style: TextStyle(fontSize: 28),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Stack(
                children: <Widget>[
                  ContainerBimby(Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Lista Clienti",
                                style: TextStyle(
                                    fontSize: 28, color: Colors.green),
                              ),
                              Text(
                                "Accedi alla tua lista clienti,\n"
                                "consulta i dettagli e crea la tua\n"
                                "lista da lavorare.",
                              )
                            ]),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          LISTA_CLIENTI,
                          style: TextStyle(fontSize: 32, color: Colors.green),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                      ])),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          _pushLL();
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          color: Colors.green,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: AnimatedContainer(
              height: bottomHeigth,
              color: Colors.green[900],
              duration: Duration(milliseconds: 500),
              child: GestureDetector(
                  onTap: _changeHeight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                "Vorwerk Bimby",
                                style: TextStyle(color: Colors.white),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    bottomHeigth == 40.0
                                        ? "Apri footer"
                                        : "Chiudi footer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    bottomHeigth == 40.0
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Termini e condizioni",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Bimby.it",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Social Media: ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        IG,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        TWITTER,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        YOUTUBE,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        FACEBOOK,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        BIMBY_COM,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ]),
                  ))),
        ));
  }

  _pushLL() {
    Navigator.pushNamed(context, '/listaClienti');
  }

  _changeHeight() {
    setState(() {
      if (bottomHeigth == 40.0) {
        bottomHeigth = 120.0;
      } else
        bottomHeigth = 40.0;
    });
  }
}
