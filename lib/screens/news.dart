import 'package:flutter/material.dart';
import 'package:goorlanews/components/news_item.dart';
import 'package:goorlanews/model/articlesHolder.dart';
import 'package:goorlanews/services/api.dart';
import 'package:provider/provider.dart';

class News extends StatefulWidget {
  News();

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = getTabController();
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Goorla News",
              style: Theme.of(context).textTheme.title,
            ),
            bottom: TabBar(
              labelColor: Colors.black,
              tabs: <Widget>[getTabs("Headlines"), getTabs("Business")],
              controller: _tabController,
            )),
        body: Container(
            child: TabBarView(controller: _tabController, children: <Widget>[
          Center(
              child: RefreshIndicator(
                  onRefresh: () => _refresh(context),
                  child:
                      Consumer<ArticlesHolder>(builder: (context, news, child) {
                    return ListView.builder(
                        itemCount: news.articles.length,
                        itemBuilder: (context, position) => Text(
                              news.articles[position].title,
                              style: Theme.of(context).textTheme.headline1,
                            ));
                  }))),
          Center(
              child: RefreshIndicator(
                  onRefresh: () => _refresh(context),
                  child: Consumer<ArticlesHolder>(
                      builder: (context, holder, child) {
                    return ListView.builder(
                        itemCount: holder.getArticles("business") == null
                            ? 0
                            : holder.getArticles("business").length,
                        itemBuilder: (context, position) =>
                            NewsItem(holder.getArticles("business")[position]));
                  })))
        ])));
  }

  TabController getTabController() {
    return TabController(length: 2, vsync: this);
  }

  Tab getTabs(String category) {
    return Tab(
      text: category,
    );
  }

  Future<bool> _refresh(BuildContext context) async {
    await Api().fetchArticles(context: context, category: "business");
    return true;
  }

  void _handleTabSelection() async {
    if (_tabController.index == 1)
      await Api().fetchArticles(context: context, category: "business");
  }
}
