import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*
This class is used to store the attributes of the messages so we can filter
for example messages by their sender.
 */
class Messages {
  String content;
  String? uid;
  String? senderUID;
  String? reciverUID;
  Timestamp? createAt;

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Messages(
      {required this.content,
      this.senderUID,
      this.reciverUID,
      this.createAt,
      this.uid});

  // Saves the Attributes via JSON
  static Messages fromJson(Map<String, dynamic> json, String id) => Messages(
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
  // Checks if the current UID is the UID of the sender
  bool get isMe => userId == senderUID;
}
