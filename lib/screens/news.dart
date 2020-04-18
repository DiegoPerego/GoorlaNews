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
  int _currentIndex = 0;

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
              isScrollable: true,
              labelColor: Colors.black,
              tabs: <Widget>[
                getTabs("Headlines"),
                getTabs("Business"),
                getTabs("Entertainment"),
                getTabs("General"),
                getTabs("Health"),
                getTabs("Science"),
                getTabs("Sports"),
                getTabs("Technology")
              ],
              controller: _tabController,
            )),
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
        body: Container(
            child: TabBarView(controller: _tabController, children: <Widget>[
          Center(
              child: RefreshIndicator(
                  onRefresh: () => _refresh(context, null),
                  child: Consumer<ArticlesHolder>(
                      builder: (context, holder, child) {
                    return ListView.builder(
                        itemCount: holder.articles.length == null
                            ? 0
                            : holder.articles.length,
                        itemBuilder: (context, position) =>
                            NewsItem(holder.articles[position]));
                  }))),
          TabItem("business"),
          TabItem("entertainment"),
          TabItem("general"),
          TabItem("health"),
          TabItem("science"),
          TabItem("sports"),
          TabItem("technology"),
        ])));
  }

  TabController getTabController() {
    return TabController(length: 8, vsync: this);
  }

  Tab getTabs(String category) {
    return Tab(
      text: category,
    );
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
                      NewsItem(holder.getArticles(category)[position]));
            })));
  }

  BottomNavigationBarItem getBottomNavItem(IconData icons, String text) {
    return BottomNavigationBarItem(icon: Icon(icons), title: Text(text));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _refresh(BuildContext context, String category) async {
    if (category == null)
      await Api().fetchArticles(context: context, category: "headlines");
    else
      await Api().fetchArticles(context: context, category: category);
    return true;
  }

  void _handleTabSelection() async {
    if (_tabController.index == 1)
      await Api().fetchArticles(context: context, category: "business");
    if (_tabController.index == 2)
      await Api().fetchArticles(context: context, category: "entertainment");
    if (_tabController.index == 3)
      await Api().fetchArticles(context: context, category: "general");
    if (_tabController.index == 4)
      await Api().fetchArticles(context: context, category: "health");
    if (_tabController.index == 5)
      await Api().fetchArticles(context: context, category: "science");
    if (_tabController.index == 6)
      await Api().fetchArticles(context: context, category: "sports");
    if (_tabController.index == 7)
      await Api().fetchArticles(context: context, category: "technology");
  }
}
