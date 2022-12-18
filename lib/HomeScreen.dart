import 'package:flutter/material.dart';
import 'package:flutter_course/screens/tabBarScreens/ChatScreen.dart';
import 'screens/tabBarScreens/MyProfileScreen.dart';
import 'screens/tabBarScreens/SettingsScreen.dart';
import 'screens/tabBarScreens/FeedScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _currentIndex = 0;
  String _currentAppBarTitle = "";
  var barColor = Color.fromRGBO(156, 145, 132, 10);

  // Different screens for BottomNavigatorBar
  final screens = [
    const FeedScreen(),
    const ChatScreen(),
    const MyProfileScreen(),
    const SettingsScreen(),
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

      appBar: AppBar(
        backgroundColor: barColor,
        automaticallyImplyLeading: false,
        title: Text(
          _currentAppBarTitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      // Change pages per Index
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: barColor,
        // iconSize: 25,
        // selectedFontSize: 20,
        // unselectedFontSize: 20,

        items: const [
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
