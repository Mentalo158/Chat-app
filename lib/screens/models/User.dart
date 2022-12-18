import 'package:cloud_firestore/cloud_firestore.dart';
/*
All relevant Attributes which are part of the User will be stored in this class
 */
class MyUser {
  String uid;
  String username;
  String email;
  DateTime birthday;
  String profileImagePath;
  String profileBannerPath;
  String bioDescription;
  String imagePaths;

  MyUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.birthday,
    this.bioDescription = '',
    this.profileImagePath = '',
    this.profileBannerPath = '',
    this.imagePaths = '',
  });

  // Converts the data into Json
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
  // "Fetches" the Data/Information from the Json
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
