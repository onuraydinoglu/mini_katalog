
import 'package:flutter/material.dart';
import 'package:mini_katalog/features/cart/pages/cart_page.dart';
import 'package:mini_katalog/features/products/data/product_repository.dart';
import 'package:mini_katalog/features/products/models/product.dart';
import 'package:mini_katalog/features/products/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<List<Product>> _productsFuture;

  String _searchQuery = '';

  final List<Product> _cartProducts = [];

  @override
  void initState() {
    super.initState();
    _productsFuture = const ProductRepository().getProducts();
  }

  void _addToCart(Product product) {
    setState(() {
      _cartProducts.add(product);
    });
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(
          products: _cartProducts,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mini Katalog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _openCart,
            tooltip: 'Sepet',
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase().trim();
                });
              },
              decoration: InputDecoration(
                hintText: 'Ürün ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),

            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://wantapi.com/assets/banner.png',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Theme.of(context).colorScheme.primary,
                    alignment: Alignment.center,
                    child: const Text(
                      'Mini Katalog',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),

            const Text(
              'Öne Çıkan Ürünler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Ürünler yüklenirken bir hata oluştu.',
                    ),
                  );
                }

                final products = snapshot.data ?? [];

                final filteredProducts = products.where((product) {
                  return product.name.toLowerCase().contains(
                    _searchQuery,
                  );
                }).toList();

                if (filteredProducts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('Aradığınız ürün bulunamadı.'),
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredProducts.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: filteredProducts[index],
                      onAddToCart: _addToCart,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
