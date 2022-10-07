import 'package:flutter/material.dart';
import 'package:flutter_course/square.dart';

// ignore: camel_case_types113

class firstScreen extends StatelessWidget {
  firstScreen({super.key});

  final List _posts = [
    'post 1',
    'post 2',
    'post 3',
    'post 4',
    'post 5',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (context, index) {
            return MySquare(
              child: _posts[index],
            );
          },
        ),
      ),
    );
  }
}
