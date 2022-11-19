import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/screens/login/AuthScreen.dart';
import 'package:flutter_course/screens/models/User.dart';
import 'package:flutter_course/screens/models/nachrichten.dart';

class DBfire {
  var userCol = FirebaseFirestore.instance.collection("users");
  var msgCol = FirebaseFirestore.instance.collection("Nachrichten");
  final userId = FirebaseAuth.instance.currentUser!.uid;

  saveUser(MyUser user) async {
    try {
      await userCol.doc(user.uid).set(user.toJson());
    } catch (e) {}
  }

  Stream<List<MyUser>> get getDiscussionUser {
    return userCol.snapshots().map(
        (event) => event.docs.map((e) => MyUser.fromJson(e.data())).toList());
  }

  Stream<List<Nachricht>> getMessage(String reciverUID,
      [bool myMessage = true]) {
    return msgCol
        .where("senderUID", isEqualTo: myMessage ? userId : reciverUID)
        .where("reciverUID", isEqualTo: myMessage ? reciverUID : userId)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Nachricht.fromJson(e.data(), e.id)).toList());
  }

  Future<bool> sendMessage(Nachricht msg) async {
    try {
      await msgCol.doc().set(msg.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
