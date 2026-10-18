import 'dart:convert';
import 'dart:io';

import 'package:mini_katalog/features/products/models/product.dart';

class ProductRepository {
  const ProductRepository();

  static const String apiUrl = 'https://wantapi.com/products.php';

  Future<List<Product>> getProducts() async {
    final client = HttpClient();

    try {
      final request = await client
          .getUrl(Uri.parse(apiUrl))
          .timeout(const Duration(seconds: 15));

      final response = await request.close().timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw HttpException('API isteği başarısız: ${response.statusCode}');
      }

      final responseBody = await utf8.decoder.bind(response).join();

      final json = jsonDecode(responseBody) as Map<String, dynamic>;

      if (json['status'] != 'success') {
        throw const FormatException('API başarısız durum döndürdü.');
      }

      final productsJson = json['data'] as List<dynamic>;

      return productsJson.map((item) {
        return Product.fromJson(item as Map<String, dynamic>);
      }).toList();
    } finally {
      client.close();
    }
  }
}
