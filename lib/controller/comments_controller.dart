import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/comments_model.dart';

class CommentsController {
  final String baseUrl = "https://jsonplaceholder.typicode.com/comments";

  Future<List<Comments>> fetchComments() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "User-Agent": "Mozilla/5.0 (Linux; Android 10) FlutterApp",
        "Accept": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Comments.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener posts");
    }
  }
}
