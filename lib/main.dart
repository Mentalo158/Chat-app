import 'package:flutter/material.dart';
import 'package:flutter_course/page/firstScreen.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      // Scaffold widget for basic page styling
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
