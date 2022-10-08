import 'package:flutter/material.dart';
import 'screens/firstScreen.dart';

class loggedIn extends StatefulWidget {
  @override
  State<loggedIn> createState() => _loggedInState();
}

class _loggedInState extends State<loggedIn> {
  int currentIndex = 0;

  final screens = [
    firstScreen(),
    Center(child: Text('Feed', style: TextStyle(fontSize: 60))),
    Center(child: Text('Chat', style: TextStyle(fontSize: 60))),
    Center(child: Text('Settings', style: TextStyle(fontSize: 60))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // state doesnt change after screen change
      // body: IndexedStack(
      //   index: currentIndex,
      //   children: screens,
      // ),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'veeJob',
          style: TextStyle(color: Color(0xffffffaa)),
        ),
        centerTitle: true,
      ),
      // Change pages per Index
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        // type: BottomNavigationBarType.fixed,
        // iconSize: 25,
        // selectedFontSize: 20,
        // unselectedFontSize: 20,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Chat',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Settings',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
