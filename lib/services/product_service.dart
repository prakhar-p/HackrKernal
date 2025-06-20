import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ProductService {
  static const _key = "products";

  Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    final List decoded = jsonDecode(data);
    return decoded.map((e) => Product.fromMap(e)).toList();
  }

  Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(products.map((e) => e.toMap()).toList());
    await prefs.setString(_key, data);
  }

  Future<void> addProduct(Product product) async {
    final list = await getProducts();
    if (list.any((p) => p.name.toLowerCase() == product.name.toLowerCase())) {
      throw Exception("Product already exists.");
    }
    list.add(product);
    await saveProducts(list);
  }

  Future<void> deleteProduct(String name) async {
    final list = await getProducts();
    list.removeWhere((p) => p.name == name);
    await saveProducts(list);
  }
}
