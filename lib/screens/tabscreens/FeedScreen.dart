import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
      child: Text("To be added soon...", textAlign: TextAlign.left, style: TextStyle(color: Colors.white),),
      )
    );
  }

  // TODO Concept for Feedscreen?
  Widget _buildList() => ListView(children: const []);

  ListTile _tile() => const ListTile();
}
