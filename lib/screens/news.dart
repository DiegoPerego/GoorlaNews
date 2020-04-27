import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:goorlanews/components/article_search.dart';
import 'package:goorlanews/components/news_item.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/model/articlesHolder.dart';
import 'package:goorlanews/services/api.dart';
import 'package:goorlanews/shared_preferences/shared_preference.dart';
import 'package:provider/provider.dart';

class News extends StatefulWidget {
  News();

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with TickerProviderStateMixin {
  SharedPref sharedPref = SharedPref();
  TabController _tabController;
  int _currentIndex = 0;
  String _title;
  bool _showTabs;
  bool _showFav;

  @override
  void initState() {
    super.initState();
    _showTabs = true;
    _showFav = false;
    _title = 'Notizie';
    _tabController = getTabController();
    _tabController.addListener(_handleTabSelection);
    loadSharedPrefs();
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
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.search, color: Colors.grey[600]),
            onPressed: () {
              showSearch(context: context, delegate: ArticleSearch());
            },
          ),
          title: Text(
            _title,
            style: Theme.of(context).textTheme.title,
          ),
          bottom: _showTabs ? getTabBar() : null),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          getBottomNavItem(Icons.home, "Notizie"),
          getBottomNavItem(Icons.star_border, "Segui"),
        ],
      ),
      body: _showTabs ? getTabBarView() : getFavList(),
      floatingActionButton: _showTabs
          ? null
          : FloatingActionButton(
              onPressed: () {
                showSearch(context: context, delegate: ArticleSearch());
              },
              child: Icon(Icons.add),
            ),
    );
  }

  //region Tab
  TabController getTabController() {
    return TabController(length: 7, vsync: this);
  }

  Tab getTabs(String category) {
    return Tab(
      text: category,
    );
  }

  TabBar getTabBar() {
    return TabBar(
      isScrollable: true,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: <Widget>[
        getTabs("Headlines"),
        getTabs("Business"),
        getTabs("Entertainment"),
        getTabs("Health"),
        getTabs("Science"),
        getTabs("Sports"),
        getTabs("Technology")
      ],
      controller: _tabController,
    );
  }

  Container getTabBarView() {
    return Container(
        child: TabBarView(controller: _tabController, children: <Widget>[
      Center(
          child: RefreshIndicator(
              onRefresh: () => _refresh(context, null),
              child:
                  Consumer<ArticlesHolder>(builder: (context, holder, child) {
                return ListView.builder(
                    itemCount: holder.articles.length == null
                        ? 0
                        : holder.articles.length,
                    itemBuilder: (context, position) =>
                        NewsItem(holder.articles[position], false));
              }))),
      TabItem("business"),
      TabItem("entertainment"),
      TabItem("health"),
      TabItem("science"),
      TabItem("sports"),
      TabItem("technology"),
    ]));
  }

  Center TabItem(String category) {
    return Center(
        child: RefreshIndicator(
            onRefresh: () => _refresh(context, category),
            child: Consumer<ArticlesHolder>(builder: (context, holder, child) {
              return ListView.builder(
                  itemCount: holder.getArticles(category) == null
                      ? 0
                      : holder.getArticles(category).length,
                  itemBuilder: (context, position) =>
                      NewsItem(holder.getArticles(category)[position], false));
            })));
  }

  void _handleTabSelection() async {
    if (_tabController.index == 1)
      await Api().fetchArticles(context: context, category: "business");
    if (_tabController.index == 2)
      await Api().fetchArticles(context: context, category: "entertainment");
    if (_tabController.index == 3)
      await Api().fetchArticles(context: context, category: "health");
    if (_tabController.index == 4)
      await Api().fetchArticles(context: context, category: "science");
    if (_tabController.index == 5)
      await Api().fetchArticles(context: context, category: "sports");
    if (_tabController.index == 6)
      await Api().fetchArticles(context: context, category: "technology");
  }

  //endregion

  BottomNavigationBarItem getBottomNavItem(IconData icons, String text) {
    return BottomNavigationBarItem(icon: Icon(icons), title: Text(text));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _title = 'Notizie';
          _showTabs = true;
          break;
        case 1:
          _title = 'Segui';
          _showTabs = false;
          break;
      }
    });
  }

  void loadSharedPrefs() async {
    LinkedHashMap<String, Article> favList = LinkedHashMap();
    Map<dynamic, dynamic> favMap = await sharedPref.read("FAVOURITE");
    favMap.forEach((key, value) {
      Article article = Article.fromJson(value);
      favList.putIfAbsent(key, () => article);
    });
    Provider.of<ArticlesHolder>(context, listen: false).favArticles = favList;
  }

  Container getFavList() {
    Provider.of<ArticlesHolder>(context).getArticlesFav().length > 0
        ? _showFav = true
        : _showFav = false;
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: Text('Notizie salvate',
                style: Theme.of(context).textTheme.title)),
        _showFav ? getFav() : emptyFavList(),
      ],
    ));
  }

  Widget getFav() {
    return Expanded(
        child: Consumer<ArticlesHolder>(builder: (context, holder, child) {
      return ListView.builder(
        itemCount: holder.getArticlesFav().length == null
            ? 0
            : holder.getArticlesFav().length,
        itemBuilder: (context, position) =>
            NewsItem(holder.getArticlesFav()[position], true),
        shrinkWrap: true,
      );
    }));
  }

  Container emptyFavList() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 24),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Text('Nessuna notizia salvata da leggere più tardi',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700])),
            ),
            Image(
              image: AssetImage('images/goorla_news.png'),
              height: 150,
              width: 150,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ));
  }

  Future<bool> _refresh(BuildContext context, String category) async {
    if (category == null)
      await Api().fetchArticles(context: context);
    else
      await Api().fetchArticles(context: context, category: category);
    return true;
  }
}
