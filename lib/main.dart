import 'package:flutter/material.dart';
import 'screens/login/logScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var currentBackgroundcolor = Colors.grey[600];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: currentBackgroundcolor,
      ),
      home: logScreen(),
    );
  }
}
