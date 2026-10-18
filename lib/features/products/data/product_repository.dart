import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mini_katalog/features/products/models/product.dart';

class ProductRepository {
  const ProductRepository();

  Future<List<Product>> getProducts() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/products.json',
    );

    final jsonList = jsonDecode(jsonString) as List<dynamic>;

    return jsonList.map((item) {
      return Product.fromJson(item as Map<String, dynamic>);
    }).toList();
  }
}