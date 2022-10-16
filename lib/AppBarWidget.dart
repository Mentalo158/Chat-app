import 'package:flutter/material.dart';
import 'package:flutter_course/screens/tabBarScreens/ChatScreen.dart';
import 'screens/tabBarScreens/ProfileScreen.dart';
import 'screens/tabBarScreens/SettingsScreen.dart';
import 'screens/tabBarScreens/HomeScreen.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidget();
}

class _AppBarWidget extends State<AppBarWidget> {
  int _currentIndex = 0;
  String _currentAppBarTitle = "";

  // Different screens for BottomNavigatorBar
  final screens = [
    HomeScreen(),
    ChatScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  // Change the appBarTitle with index
  void appBarTitle(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          {
            _currentAppBarTitle = "Home";
          }
          break;
        case 1:
          {
            _currentAppBarTitle = "Chat";
          }
          break;
        case 2:
          {
            _currentAppBarTitle = "Profile";
          }
          break;
        case 3:
          {
            _currentAppBarTitle = "Settings";
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    appBarTitle(_currentIndex);

    return Scaffold(
      // stateful widgets dont reset after screen change
      // body: IndexedStack(
      //   index: currentIndex,
      //   children: screens,
      // ),

      appBar: AppBar(
        backgroundColor: Color(0xFF091123),
        automaticallyImplyLeading: false,
        title: Text(
          _currentAppBarTitle,
          style: TextStyle(color: Colors.white),
        ),
      ),
      // Change pages per Index
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF091123),
        // iconSize: 25,
        // selectedFontSize: 20,
        // unselectedFontSize: 20,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
