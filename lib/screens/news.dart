import 'package:flutter/material.dart';
import 'package:goorlanews/components/article_search.dart';
import 'package:goorlanews/components/news_item.dart';
import 'package:goorlanews/components/news_list.dart';
import 'package:goorlanews/model/article.dart';
import 'package:goorlanews/services/db_repo.dart';
import 'package:provider/provider.dart';

import '../news_bloc.dart';

class News extends StatefulWidget {
  News();

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with TickerProviderStateMixin {
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
    final bloc = Provider.of<NewsBloc>(context, listen: false);
    bloc.getNews();
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
      TabItem("general"),
      TabItem("business"),
      TabItem("entertainment"),
      TabItem("health"),
      TabItem("science"),
      TabItem("sports"),
      TabItem("technology"),
    ]));
  }

  Center TabItem(String category) {
    final bloc = Provider.of<NewsBloc>(context, listen: false);
    bloc.getNews();
    return Center(
        child: RefreshIndicator(
            onRefresh: () => bloc.refresh(_tabController.index),
            child: NewsList(false)));
  }

  void _handleTabSelection() async {
    if (!_tabController.indexIsChanging) {
      final bloc = Provider.of<NewsBloc>(context, listen: false);
      bloc.changeCategory(_tabController.index);
    }
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

  Container getFavList() {
    DbRepository dbRepository = DbRepository();
    dbRepository.getArticles().length > 0 ? _showFav = true : _showFav = false;
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: Text('Notizie salvate',
                style: Theme.of(context).textTheme.title)),
        _showFav ? getFav(dbRepository.getArticles()) : emptyFavList(),
      ],
    ));
  }

  Widget getFav(List<Article> articles) {
    return Expanded(
        child: ListView.builder(
      itemCount: articles.length == null ? 0 : articles.length,
      itemBuilder: (context, position) => NewsItem(articles[position], true),
      shrinkWrap: true,
    ));
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
}
