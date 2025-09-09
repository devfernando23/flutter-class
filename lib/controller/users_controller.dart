import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class UsersController {
  final String baseUrl = "https://dummyjson.com/users";

  /// Obtener lista de usuarios
  Future<List<User>> fetchUsers() async {
    final res = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "Accept": "application/json",
      },
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final List users = data["users"]; // 👈 DummyJSON devuelve en "users"
      return users.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Error ${res.statusCode}: ${res.body}");
    }
  }

  /// Crear usuario
  Future<User> createUser(String name, String email) async {
    final res = await http.post(
      Uri.parse("$baseUrl/add"), // 👈 DummyJSON requiere /add
      body: jsonEncode({"firstName": name, "email": email}),
      headers: {"Content-Type": "application/json"},
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Error al crear usuario: ${res.statusCode}");
    }
  }

  /// Actualizar usuario
  Future<User> updateUser(int id, String name, String email) async {
    final res = await http.put(
      Uri.parse("$baseUrl/$id"),
      body: jsonEncode({"firstName": name, "email": email}),
      headers: {"Content-Type": "application/json"},
    );
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Error al actualizar usuario: ${res.statusCode}");
    }
  }

  /// Eliminar usuario
  Future<bool> deleteUser(int id) async {
    final res = await http.delete(Uri.parse("$baseUrl/$id"));
    if (res.statusCode == 200) {
      return true; // 👈 DummyJSON devuelve el objeto eliminado
    }
    return false;
  }
}