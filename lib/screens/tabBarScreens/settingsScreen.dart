import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () => FirebaseAuth.instance.signOut(),
            child: Text(
              'Sign Out',
              style: TextStyle(fontSize: 25),
            ),
          )
        ],
      ),
    );
  }
}
