
import 'package:flutter/material.dart';
import 'package:mini_katalog/features/products/models/product.dart';

class CartPage extends StatelessWidget {
  final List<Product> products;

  const CartPage({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepetim'),
      ),
      body: products.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text('Sepetiniz boş'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  child: ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported_outlined,
                        );
                      },
                    ),
                    title: Text(product.name),
                    subtitle: Text(
                      '${product.price.toStringAsFixed(2)} ${product.currency}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
