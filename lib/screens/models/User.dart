class MyUser {
  final String username;

  MyUser({
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
      };
}
