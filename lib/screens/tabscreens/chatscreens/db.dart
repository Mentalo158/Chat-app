import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/screens/models/User.dart';
import 'package:flutter_course/screens/models/nachrichten.dart';

class DBfire {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final userCol = FirebaseFirestore.instance.collection("users");
  final msgCol = FirebaseFirestore.instance.collection("messages");

  saveUser(MyUser user) async {
    try {
      await userCol.doc(user.uid).set(user.toJson());
    } catch (e) {
      print(e);
    }
  }

  Stream<List<MyUser>> get getDiscussionUser {
    //Filtert den eigenen User aus der Liste aus
    return userCol.where("uid", isNotEqualTo: userId).snapshots().map(
        (event) => event.docs.map((e) => MyUser.fromJson(e.data())).toList());
  }

  Stream<List<Messages>> getMessage(String reciverUID,
      [bool myMessage = true]) {
    return msgCol
        .where("senderUID", isEqualTo: myMessage ? userId : reciverUID)
        .where("reciverUID", isEqualTo: myMessage ? reciverUID : userId)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Messages.fromJson(e.data(), e.id)).toList());
  }

  Future<bool> sendMessage(Messages msg) async {
    try {
      await msgCol.doc().set(msg.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
