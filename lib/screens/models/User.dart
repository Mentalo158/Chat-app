import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String? uid;
  final String username;
  String email;
  DateTime birthday;
  String profileImagePath;
  String profileBannerPath;
  String bioDescription;
  String imagePaths;

  MyUser({
    this.uid,
    required this.username,
    required this.email,
    required this.birthday,
    this.bioDescription = '',
    this.profileImagePath = '',
    this.profileBannerPath = '',
    this.imagePaths = '',
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
        'birthday': birthday,
        'bioDescription': bioDescription,
        'profileImagePath': profileImagePath,
        'profileBannerPath': profileBannerPath,
        'imagePaths': imagePaths,
      };

  static MyUser fromJson(Map<String, dynamic> json) => MyUser(
        uid: json['uid'],
        username: json['username'],
        email: json['email'],
        birthday: (json['birthday'] as Timestamp).toDate(),
        bioDescription: json['bioDescription'],
        profileImagePath: json['profileImagePath'],
        profileBannerPath: json['profileBannerPath'],
        imagePaths: json['imagePaths'],
      );
}
