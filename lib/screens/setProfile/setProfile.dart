import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/HomeScreen.dart';
import 'package:intl/intl.dart';
import '../models/User.dart';

// TODO give the user a cancel button to stop & unreg button lol

class setProfile extends StatefulWidget {
  @override
  State<setProfile> createState() => _setProfileState();
}

class _setProfileState extends State<setProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isUsernameParsed = false;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final dateController = TextEditingController();

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
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: "Select Birthdate"),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          dateController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Birthday';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 4),
                  ElevatedButton.icon(
                    onPressed: saveProfile,
                    icon: const Icon(Icons.save_alt_outlined),
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
