import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/screens/login/db.dart';
import 'package:flutter_course/screens/models/User.dart';
import 'package:flutter_course/screens/models/nachrichten.dart';
import 'package:flutter_course/widgets/NachrichtenWidg.dart';

class InChat extends StatefulWidget {
  InChat({Key? key, this.user}) : super(key: key);
  final MyUser? user;

  @override
  State<InChat> createState() => _InChatState();
}

class _InChatState extends State<InChat> {
  final msgCont = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user!.username),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<Nachricht>>(
            stream: DBfire().getMessage(widget.user!.uid),
            builder: (context, s1) {
              if (s1.hasData) {
                return StreamBuilder<List<Nachricht>>(
                  stream: DBfire().getMessage(widget.user!.uid, false),
                  builder: (context, s2) {
                    if (s2.hasData) {
                      var messages = [...s1.data!, ...s2.data!];
                      messages
                          .sort((i, j) => i.createAt!.compareTo(j.createAt!));
                      // Gibt Nachrichten so aus dass die neuste unten ist
                      messages = messages.reversed.toList();
                      return ListView.builder(
                        itemExtent: 50,
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return NachrichtenWid(
                            msg: message,
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
          Align(
            // Add Validation
            alignment: const Alignment(0.0, 0.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: msgCont,
                validator: (value) => value!.isEmpty ? "No blank space" : null,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: _sendMessage,
                        icon: const Icon(
                          Icons.send,
                          color: Color(0xFF4d4d4d),
                        )),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _sendMessage() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    final userId = FirebaseAuth.instance.currentUser!.uid;
    var msg = Nachricht(
      content: msgCont.text,
      createAt: Timestamp.now(),
      reciverUID: widget.user!.uid,
      senderUID: userId,
    );
    msgCont.clear();
    await DBfire().sendMessage(msg);
  }
}
