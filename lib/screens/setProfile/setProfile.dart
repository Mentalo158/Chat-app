import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/HomeScreen.dart';
import '../models/User.dart';

// TODO give the user a cancel to stop & unreg button lol

class setProfile extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isUsernameParsed = false;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) => isUsernameParsed
      ? const HomeScreen()
      : Scaffold(
          appBar: AppBar(
            title: const Text('Set Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: usernameController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(labelText: 'Username'),
                    //TODO Change expression look
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: saveProfile,
                    icon: const Icon(Icons.email_outlined),
                    label: const Text(
                      'Save Profile',
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                ],
              ),
            ),
          ),
        );

  // TODO go to the next site after saving
  Future saveProfile() async {
    if (formKey.currentState!.validate()) {
      final currentUserId = auth.currentUser!.uid;
      final documentUser =
          FirebaseFirestore.instance.collection('users').doc(currentUserId);

      final user = MyUser(
        username: usernameController.text.trim(),
      );
      final json = user.toJson();

      await documentUser.set(json);
    }
  }
}
