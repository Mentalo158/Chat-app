import 'package:flutter/material.dart';

class settingsScreen extends StatelessWidget {
  const settingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildList());
  }

  Widget _buildList() => ListView(children: [
        // TODO Routes for each tile
        _tile('Test'),
        _tile('Test'),
        // Divider(),
        _tile('Change languegue'),
        _tile('Sing out'),
        // ...
      ]);

  ListTile _tile(String title) => ListTile(
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)));
}
