import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Product.dart';

class ApiService {
  static const String url = "https://api.ppb.widiarrohman.my.id/api/2026/uts/B/kelompok1/products";

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        List<dynamic> data = body['data'];
        return data.asMap().entries.map((e) => Product.fromJson(e.value, e.key)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}