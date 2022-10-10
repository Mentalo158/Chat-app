import 'package:flutter/material.dart';
import 'package:flutter_course/screens/chatScreen.dart';
import 'screens/profileScreen.dart';
import 'screens/settingsScreen.dart';
import 'screens/homeScreen.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  int currentIndex = 0;

  final screens = [
    homeScreen(),
    chatScreen(),
    profileScreen(),
    settingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // stateful widgets dont reset after screen change
      // body: IndexedStack(
      //   index: currentIndex,
      //   children: screens,
      // ),

      // Appbar maybe?
      // appBar: AppBar(
      //   backgroundColor: Colors.grey,
      //   title: Text(
      //     'veeJob',
      //     style: TextStyle(color: Color(0xffffffaa)),
      //   ),
      //   centerTitle: true,
      // ),

      // Change pages per Index
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[800],
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
