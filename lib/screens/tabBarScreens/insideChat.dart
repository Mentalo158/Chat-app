import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/screens/login/AuthScreen.dart';
import 'package:flutter_course/screens/login/db.dart';
import 'package:flutter_course/screens/models/User.dart';
import 'package:flutter_course/screens/models/nachrichten.dart';
import 'package:flutter_course/widgets/NachrichtenWidg.dart';

class InChat extends StatelessWidget {
  InChat({Key? key, this.user}) : super(key: key);
  final MyUser? user;
  var msgCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.username!),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<Nachricht>>(
            stream: DBfire().getMessage(user!.uid!),
            builder: (context, s1) {
              if (s1.hasData) {
                return StreamBuilder<List<Nachricht>>(
                  stream: DBfire().getMessage(user!.uid!, false),
                  builder: (context, s2) {
                    if (s2.hasData) {
                      var messages = [...s1.data!, ...s2.data!];
                      messages
                          .sort((i, j) => i.createAt!.compareTo(j.createAt!));
                      // Gibt Nachrichten so aus dass die neuste unten ist
                      messages = messages.reversed.toList();
                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            child: NachrichtenWid(
                              msg: msg,
                            ),
                          );
                        },
                      );
                    } else
                      return Center(child: CircularProgressIndicator());
                  },
                );
              } else
                return Center(child: CircularProgressIndicator());
            },
          )),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: msgCont,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    final userId = FirebaseAuth.instance.currentUser!.uid;
                    var msg = Nachricht(
                      content: msgCont.text,
                      createAt: Timestamp.now(),
                      reciverUID: user!.uid,
                      senderUID: userId,
                    );
                      msgCont.clear();
                    await DBfire().sendMessage(msg);
                  },
                  icon: Icon(Icons.send))
            ],
          )
        ],
      ),
    );
  }
}
