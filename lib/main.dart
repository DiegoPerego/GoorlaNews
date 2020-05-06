import 'package:flutter/material.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/screens/news_detail.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'news_bloc.dart';
import 'screens/news.dart';
import 'themes/theme.dart';

const String NewsBox = "NewsBox";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goorla News',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => News(),
          '/newsDetail': (context) => NewsDetail(),
        },
      ),
    );
  }
}
