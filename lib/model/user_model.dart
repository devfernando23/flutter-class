class User {
  final int id;
  final String name;
  final String email;
  final String avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: "${json['firstName'] ?? ''} ${json['lastName'] ?? ''}".trim(),
      email: json['email'] ?? '',
      avatar: json['image'] ??
          "https://cdn-icons-png.flaticon.com/512/149/149071.png",
    );
  }
}
