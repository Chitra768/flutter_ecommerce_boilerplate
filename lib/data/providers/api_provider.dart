import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/product_model.dart';
import '../mock/mock_products.dart';

class ApiProvider {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      if (response.statusCode != 200) {
        return MockProducts.products;
      }
      final decoded = json.decode(response.body);
      final List<dynamic> list = decoded is List
          ? decoded
          : (decoded is Map && decoded['data'] != null ? decoded['data'] : []);
      final products = <Product>[];
      for (var i = 0; i < list.length; i++) {
        try {
          final item = list[i];
          if (item is Map) {
            products.add(Product.fromJson(Map<String, dynamic>.from(item)));
          }
        } catch (_) {
          // skip malformed item
        }
      }
      return products.isEmpty ? MockProducts.products : products;
    } catch (_) {
      // Network/DNS unreachable (e.g. emulator can't resolve fakestoreapi.com)
      return MockProducts.products;
    }
  }

  Future<Product> getProductDetails(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/$id'));
      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      }
    } catch (_) {}
    // Fallback: find in mock data
    final list = MockProducts.products.where((p) => p.id == id).toList();
    if (list.isNotEmpty) return list.first;
    throw Exception('Product not found');
  }

  Future<List<String>> getCategories() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/products/categories'));
      if (response.statusCode == 200) {
        List<dynamic> jsonRes = json.decode(response.body);
        return jsonRes.map((e) => e.toString()).toList();
      }
    } catch (_) {}
    return MockProducts.categories;
  }
}
