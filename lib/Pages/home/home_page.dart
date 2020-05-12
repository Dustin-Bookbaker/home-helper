import 'package:flutter/material.dart';
import 'package:homehelper/Pages/ticket/accepted_tickets_page.dart';
import 'package:homehelper/Pages/ticket/my_tickets_page.dart';
import 'package:homehelper/Pages/ticket/open_tickets_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: _currentIndex,
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Home Office Helper'),
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelStyle: TextStyle(fontSize: 18.0),
            tabs: [
              Tab(
                child: Text(
                  'Offene Tickets',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  'Meine Tickets',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  'Akzeptierte Tickets',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          controller: _tabController,
          children: [
            OpenTicketsPage(),
            MyTicketsPage(),
            AcceptedTicketsPage(),
          ],
        ),
      );

//  void setIndex() {
//    setState(() {
//      _currentIndex = _tabController.index;
//    });
//  }
}
