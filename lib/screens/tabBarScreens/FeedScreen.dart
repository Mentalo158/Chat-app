import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }

  // TODO Concept for home?
  Widget _buildList() => ListView(children: []);

  ListTile _tile() => const ListTile();
}
