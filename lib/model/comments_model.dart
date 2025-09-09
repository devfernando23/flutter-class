/// Modelo de Comments (JSONPlaceholder)
class Comments {
  final int id;
  final String name;
  final String email;
  final String body;

  Comments({
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(id: json['id'], name: json['name'], email:json['email'], body: json['body']);
  }
}
