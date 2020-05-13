import 'package:flutter/material.dart';
import 'package:homehelper/Pages/home/home_page.dart';
import 'package:homehelper/Pages/messages/messages_page.dart';
import 'package:homehelper/Pages/profile/profile_page.dart';

class BottomNavigation extends StatefulWidget {
  /// Tab indicating, which page currently is displayed.
  final TabItem tab;
  // ignore: public_member_api_docs
  BottomNavigation({this.tab = TabItem.home});

  @override
  _BottomNavigationState createState() => _BottomNavigationState(tab);
}

class _BottomNavigationState extends State<BottomNavigation> {
  _BottomNavigationState(this._currentTab);
  TabItem _currentTab;

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () {
          // Avoid popping if not on HomeScreen
          var result = (_currentTab == TabItem.home);
          if (!result) _selectTab(TabItem.home);
          return Future.value(result);
        },
        child: Scaffold(
          body: TabHelper.route(_currentTab)(context),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: TabHelper.index(_currentTab),
            onTap: (index) => _selectTab(TabHelper.item(index)),
            iconSize: 26.0,
            selectedItemColor: Colors.lightGreen,
            unselectedItemColor: Colors.grey,
            items: [
              for (var item in TabItem.values)
                BottomNavigationBarItem(
                    icon: Icon(TabHelper.icon(item)),
                    title: Text(
                      TabHelper.description(item),
                    )),
            ],
          ),
        ),
      );
}

// Todo Add more
enum TabItem { home, profile, messages }

abstract class TabHelper {
  // ignore: public_member_api_docs
  static TabItem item(int index) {
// Todo Add more
    switch (index) {
      case 0:
        return TabItem.home;
      case 1:
        return TabItem.profile;
      case 2:
        return TabItem.messages;
      default:
        return TabItem.home;
    }
  }

  // ignore: public_member_api_docs
  static int index(TabItem tabItem) {
    // Todo Add more
    switch (tabItem) {
      case TabItem.home:
        return 0;
      case TabItem.profile:
        return 1;
      case TabItem.messages:
        return 2;
      default:
        return 0;
    }
  }

  // ignore: public_member_api_docs
  static String description(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return 'Home';
      case TabItem.profile:
        return 'Profil';
      case TabItem.messages:
        return 'Nachrichten';
      default:
        return '';
    }
  }

  // ignore: public_member_api_docs
  static IconData icon(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return Icons.home;
      case TabItem.profile:
        return Icons.account_circle;
      case TabItem.messages:
        return Icons.message;
      default:
        return Icons.adb;
    }
  }

  // ignore: public_member_api_docs
  static WidgetBuilder route(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return (context) => HomePage();
      case TabItem.profile:
        return (context) => ProfilePage();
      case TabItem.messages:
        return (context) => MessagesPage();
      default:
        return (context) => HomePage();
    }
  }
}
