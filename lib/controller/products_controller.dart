import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ProductsController {
  final String baseUrl = "https://fakestoreapi.com/products";

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener productos");
    }
  }
}
