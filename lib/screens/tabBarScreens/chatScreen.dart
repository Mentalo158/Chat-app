import 'package:flutter/material.dart';
import 'package:flutter_course/screens/login/db.dart';
import 'package:flutter_course/screens/models/User.dart';
import 'package:flutter_course/screens/tabBarScreens/insideChat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direct Messages"),
      ),
      // Ausgabe der User Liste (noch werden ALLE User angezeigt)
      // Null Error wenn ich chat anklicke unbedingt fixen
      body: StreamBuilder<List<MyUser>>(
          stream: DBfire().getDiscussionUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data;
              return ListView.builder(
                  itemCount: users!.length,
                  itemBuilder: (ctx, i) {
                    final user = users[i];
                    return ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => InChat(user: user),
                        ),
                      ),
                      leading: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: Icon(Icons.person),
                      ),
                      title: Text(user.username),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
