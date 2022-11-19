import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String username;
  String email;
  DateTime birthday;
  String profileImagePath;
  String profileBannerPath;

  MyUser({
    required this.username,
    required this.email,
    required this.birthday,
    this.profileImagePath = '',
    this.profileBannerPath = '',
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'birthday': birthday,
        'profileImagePath': profileImagePath,
        'profileBannerPath': profileBannerPath,
      };

  static MyUser fromJson(Map<String, dynamic> json) => MyUser(
        username: json['username'],
        email: json['email'],
        birthday: (json['birthday'] as Timestamp).toDate(),
        profileImagePath: json['profileImagePath'],
        profileBannerPath: json['profileBannerPath'],
      );
}
