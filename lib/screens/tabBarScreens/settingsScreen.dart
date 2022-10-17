import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.arrow_back, size: 32),
            label: Text('Sign out'),
          )
        ],
      ),
    );
  }

  Widget _buildList() => ListView(children: [
        // TODO Routes for each tile
        _tile('Test'),
        _tile('Design'),
        _tile('Change languegue'),
        _tile('Sing out'),
      ]);

  ListTile _tile(String title) => ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );
}
