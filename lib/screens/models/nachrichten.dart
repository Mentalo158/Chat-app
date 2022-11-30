import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Nachricht {
  String content;
  String? uid;
  String? senderUID;
  String? reciverUID;
  Timestamp? createAt;

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Nachricht(
      {required this.content,
      this.senderUID,
      this.reciverUID,
      this.createAt,
      this.uid});

  static Nachricht fromJson(Map<String, dynamic> json, String id) => Nachricht(
        content: json["content"],
        senderUID: json["senderUID"],
        reciverUID: json["receiverUID"],
        createAt: json["createAt"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "senderUID": senderUID,
        "reciverUID": reciverUID,
        "createAt": createAt
      };

  bool get isMe => userId == senderUID;
}
