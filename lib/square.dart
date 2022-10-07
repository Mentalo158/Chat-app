import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  final String child;

  const MySquare({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 200,
        color: Colors.blue,
        child: Text(child),
      ),
    );
  }
}
