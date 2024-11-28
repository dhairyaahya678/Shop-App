import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductRepository {
  final String baseUrl = 'https://api.escuelajs.co/api/v1';

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
