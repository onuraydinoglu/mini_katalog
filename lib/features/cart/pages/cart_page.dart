import 'package:flutter/material.dart';
import 'package:mini_katalog/features/products/models/product.dart';

class CartPage extends StatefulWidget {
  final List<Product> products;
  final void Function(int) onRemove;

  const CartPage({super.key, required this.products, required this.onRemove});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeProduct(int index) {
    setState(() {
      widget.onRemove(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ürün sepetten kaldırıldı'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sepetim')),
      body: widget.products.isEmpty
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
                  Text(
                    'Sepetiniz boş',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Henüz sepetinize ürün eklemediniz.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                final product = widget.products[index];

                return Card(
                  child: ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported_outlined);
                      },
                    ),
                    title: Text(product.name),
                    subtitle: Text(
                      '${product.price.toStringAsFixed(2)} ${product.currency}',
                    ),
                    trailing: IconButton(
                      tooltip: 'Ürünü sil',
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        _removeProduct(index);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
