import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/Screens/Models/User.dart';
import 'package:flutter_course/screens/login/AuthScreen.dart';
import 'package:flutter_course/screens/login/db.dart';

class Nachricht {
  String? content;
  String? uid;
  String? senderUID;
  String? reciverUID;
  Timestamp? createAt;

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Nachricht(
      {this.content, this.senderUID, this.reciverUID, this.createAt, this.uid});

  Nachricht.fromJson(Map<String, dynamic> json, String id) {
    uid = id;
    content = json["conte"];
    senderUID = json["senderUID"];
    reciverUID = json["reciverUID"];
    createAt = json["createAt"];
  }
  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "senderUID": senderUID,
      "reciverUID": reciverUID,
      "createAt": createAt
    };
  }

  bool get isMe => userId == senderUID;
}
