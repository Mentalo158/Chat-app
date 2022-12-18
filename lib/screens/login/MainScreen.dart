import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/screens/login/AuthScreen.dart';
import 'package:flutter_course/screens/login/VerifyEmailScreen.dart';

// The MainScreen checks the current auth state of the user and decides which screen to show
// If the user is Registred he will grant access to HomeScreen through the VerifyEmailScreen class
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else if (snapshot.hasData) {
            return const VerifyEmailScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
