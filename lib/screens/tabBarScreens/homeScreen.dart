import 'package:flutter/material.dart';

// ignore: camel_case_types113

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }

  // TODO Concept for home?
  Widget _buildList() => ListView(children: []);

  ListTile _tile() => ListTile();
}
