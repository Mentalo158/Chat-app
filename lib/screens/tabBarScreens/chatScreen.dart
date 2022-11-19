import 'package:flutter/material.dart';
import 'package:flutter_course/screens/login/db.dart';
import 'package:flutter_course/screens/models/User.dart';
import 'package:flutter_course/screens/tabBarScreens/insideChat.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direct Messages"),
      ),
      // Ausgabe der User Liste (noch werden ALLE User angezeigt)
      // username muss noch angezeigt werden anstatt email
      //Null Error wenn ich chat anklicke unbedingt fixen
      body: StreamBuilder<List<MyUser>>(
          stream: DBfire().getDiscussionUser,
          builder: (_, s) {
            if (s.hasData) {
              final users = s.data;
              return ListView.builder(
                  itemCount: users!.length,
                  itemBuilder: (ctx, i) {
                    final user = users[i];
                    return ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => InChat(),
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
                      title: Text(user.email!),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
