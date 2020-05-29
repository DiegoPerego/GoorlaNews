import 'package:flutter/material.dart';
import 'package:goorlanews/bimbi/bimbi_bloc.dart';
import 'package:goorlanews/bimbi/components/appbar_bimby.dart';
import 'package:goorlanews/bimbi/components/bimbi_list_item.dart';
import 'package:goorlanews/bimbi/models/customer.dart';
import 'package:provider/provider.dart';

class ListaClienti extends StatefulWidget {
  ListaClienti();

  @override
  _ListaClientiState createState() => _ListaClientiState();
}

class _ListaClientiState extends State<ListaClienti>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = getTabController();
    _tabController.addListener(_handleTabSelection);
    final bloc = Provider.of<BimbiBloc>(context, listen: false);
    bloc.getCustomers();
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
        automaticallyImplyLeading: false,
        title: AppBarBimby("Lista Clienti"),
        bottom: getTabBar(),
      ),
      body: getTabBarView(),
    );
  }

  TabBar getTabBar() {
    return TabBar(
      labelColor: Colors.green,
      indicatorColor: Colors.green,
      unselectedLabelColor: Colors.black,
      tabs: <Widget>[
        getTabs("Lista"),
        getTabs("Da Lavorare"),
      ],
      controller: _tabController,
    );
  }

  Container getTabBarView() {
    return Container(
        color: Colors.grey[300],
        child: Container(
            child: TabBarView(controller: _tabController, children: <Widget>[
          bimbyList(),
          bimbyList(),
        ])));
  }

  void _handleTabSelection() async {
    if (!_tabController.indexIsChanging) {
      final bloc = Provider.of<BimbiBloc>(context, listen: false);
      bloc.changeCategory(_tabController.index);
    }
  }

  TabController getTabController() {
    return TabController(length: 2, vsync: this);
  }

  Tab getTabs(String category) {
    return Tab(
      text: category,
    );
  }

  Widget bimbyList() {
    final bloc = Provider.of<BimbiBloc>(context, listen: false);
    return StreamBuilder<List<Customer>>(
        stream: bloc.customers,
        builder: (context, AsyncSnapshot<List<Customer>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, position) =>
                    BimbiListItem(snapshot.data[position]));
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}
