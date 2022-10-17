import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/screens/login/AuthScreen.dart';
import 'package:flutter_course/screens/login/VerifyEmailScreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // ignore: unrelated_type_equality_checks
          if (snapshot.connectionState == ConnectionState) {
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
