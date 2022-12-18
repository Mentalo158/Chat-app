import 'package:flutter_course/screens/login/SignUpWidget.dart';
import 'SignInWidget.dart';
import 'package:flutter/material.dart';

// The class AuthScreen is used for switching between SignIn and SingUp via a boolean toggle switch
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? SignInWidget(onClickedSignUp: toggle)
      : SignUpWidget(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
