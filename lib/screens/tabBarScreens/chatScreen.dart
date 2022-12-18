import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/screens/imageLoader/ImageLoader.dart';
import 'package:flutter_course/screens/login/db.dart';
import 'package:flutter_course/screens/models/User.dart';
import 'package:flutter_course/screens/tabBarScreens/UserProfile.dart';
import 'package:flutter_course/screens/tabBarScreens/insideChat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ausgabe der User Liste (noch werden ALLE User angezeigt)
      body: StreamBuilder<List<MyUser>>(
          stream: DBfire().getDiscussionUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data;
              return ListView.builder(
                  itemExtent: 65,
                  itemCount: users!.length,
                  itemBuilder: (ctx, i) {
                    final user = users[i];
                    return FutureBuilder(
                      future: ImageLoader.getImage(user.profileImagePath),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final image = snapshot.data;
                          return ListTile(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => InChat(user: user),
                              ),
                            ),
                            leading: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => InChat(user: user),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserProfile(user: user))),
                                child: ClipOval(
                                  child: Image.network(
                                    image,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              user.username,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => InChat(user: user),
                              ),
                            ),
                            leading: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserProfile(user: user))),
                              child: const ClipOval(
                                child: Image(
                                  width: 50,
                                  height: 50,
                                  image: AssetImage(
                                      'assets/images/blankprofile.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              user.username,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
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



                      // onTap: () => Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => InChat(user: user),
                      //   ),
                      // ),
                      // leading: FutureBuilder(
                      //   future: ImageLoader.getImage(user.profileImagePath),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       final image = snapshot.data;
                      //       ClipOval(
                      //         child: Image.network(
                      //           image,
                      //           width: 100,
                      //           height: 100,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       );
                      //     } else if (snapshot.hasError) {
                      //       const ClipOval(
                      //           child: Image(
                      //         width: 100,
                      //         height: 100,
                      //         image:
                      //             AssetImage('assets/images/blankprofile.jpg'),
                      //         fit: BoxFit.cover,
                      //       ));
                      //     }
                      //     return const Center(
                      //         child: CircularProgressIndicator());
                      //   },
                      // ),

                      // GestureDetector( onTap: () => Navigator.of(context).push( MaterialPageRoute( builder: (context) => UserProfile(user: user))), child: Icon(Icons.person)),