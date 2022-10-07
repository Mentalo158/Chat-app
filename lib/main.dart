import 'package:flutter/material.dart';
import 'package:flutter_course/page/firstPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // Rerender state
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TabBar get _tabBar => const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.flight)),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_car)),
        ],
      );
  // The build method creates the widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Scaffold widget for basic page styling
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: const Text(
              'veeJob',
              style: TextStyle(color: Color(0xffffffaa)),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: Colors.black,
                child: _tabBar,
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              firstPage(),
              Center(child: Text('Tab 2 Content')),
              Center(child: Text('Tab 3 Content')),
            ],
          ),
        ),
      ),
    );
  }
}
