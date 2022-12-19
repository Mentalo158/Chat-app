import 'package:flutter/material.dart';
import 'package:flutter_course/screens/models/nachrichten.dart';

/*
A widget for the messages.
 */
class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key, required this.msg}) : super(key: key);
  final Messages msg;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var date = msg.createAt!.toDate().toLocal();
    return Row(
      mainAxisAlignment:
          msg.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        //A Stack to output the messages from top to bottom
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(right: 30, left: 20, top: 5),
              decoration: BoxDecoration(
                  color: msg.isMe
                      ? Color.fromRGBO(85, 107, 47, 100)
                      : Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft:
                        msg.isMe ? Radius.circular(10) : Radius.circular(0),
                    bottomRight:
                        msg.isMe ? Radius.circular(0) : Radius.circular(10),
                  )),
              constraints: BoxConstraints(
                  minWidth: 30, minHeight: 40, maxWidth: width / 1.1),
              child: Text(
                msg.content,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(right: 5, bottom: 5),
                child: Text(
                  "${date.hour}h${date.minute}",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
