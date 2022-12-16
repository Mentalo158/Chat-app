import 'package:flutter/material.dart';
import 'package:flutter_course/screens/login/MainScreen.dart';
import 'package:flutter_course/screens/login/Utils.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});
  var currentBackgroundcolor = Color(0xFF1e1e1e);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: currentBackgroundcolor,
      ),
      home: MainScreen(),
    );
  }
}
