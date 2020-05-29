import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:goorlanews/bimbi/bimbi_bloc.dart';
import 'package:goorlanews/bimbi/screens/home.dart';
import 'package:goorlanews/bimbi/screens/lista_clienti.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/screens/news_detail.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'extra/bimbi.dart';
import 'news_bloc.dart';
import 'themes/theme.dart';

const String NewsBox = "NewsBox";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());

  GoogleMap.init("AIzaSyA5v-tNzDEpLt2qhskJiy-iFlhv_UwIZuQ");
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.openBox<Article>(NewsBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        Provider<NewsBloc>(create: (_) => NewsBloc()),
        Provider<BimbiBloc>(create: (_) => BimbiBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goorla News',
        theme: appThemeBimby,
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
//          '/': (context) => News(),
//          '/': (context) => TodoApp(),
//          '/': (context) => Maps(),
//          '/': (context) => Bimbi(),
          '/newsDetail': (context) => NewsDetail(),
          '/listaClienti': (context) => ListaClienti(),
        },
      ),
    );
  }
}
