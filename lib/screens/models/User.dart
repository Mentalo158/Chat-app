class MyUser {
  final String username;
  final String email;
  final DateTime birthday;
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
}
