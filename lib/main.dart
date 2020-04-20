import 'package:flutter/material.dart';
import 'package:goorlanews/model/articlesHolder.dart';
import 'package:goorlanews/screens/news_detail.dart';
import 'package:goorlanews/screens/search.dart';
import 'package:provider/provider.dart';

import 'screens/news.dart';
import 'themes/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return ChangeNotifierProvider(
      create: (context) => ArticlesHolder(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goorla News',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => News(),
          '/newsDetail': (context) => NewsDetail(),
          '/search': (context) => Search(),
        },
      ),
    );
  }
}
