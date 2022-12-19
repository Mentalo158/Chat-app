import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Text("To be added soon...", textAlign: TextAlign.left, style: TextStyle(color: Colors.white),),
      )
    );
  }

  // TODO Concept for home?
  Widget _buildList() => ListView(children: []);

  ListTile _tile() => const ListTile();
}
