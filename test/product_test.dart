import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/features/products/models/product.dart';
import 'package:mini_katalog/features/products/data/product_repository.dart';

void main() {
  group('Ürün modeli testleri', () {
    test('JSON verisi Product nesnesine dönüştürülür', () {
      final json = {
        'id': 1,
        'title': 'Test Ürünü',
        'description': 'Test açıklaması',
        'price': 99.90,
        'category': 'Elektronik',
        'image': 'assets/images/test.png',
      };

      final product = Product.fromJson(json);

      expect(product.id, 1);
      expect(product.title, 'Test Ürünü');
      expect(product.price, 99.90);
      expect(product.category, 'Elektronik');
    });

    test('Product nesnesi JSON verisine dönüştürülür', () {
      const product = Product(
        id: 2,
        title: 'Kulaklık',
        description: 'Kablosuz kulaklık',
        price: 250.0,
        category: 'Elektronik',
        image: 'assets/images/kulaklik.png',
      );

      final json = product.toJson();

      expect(json['id'], 2);
      expect(json['title'], 'Kulaklık');
      expect(json['price'], 250.0);
    });

    test('Yerel JSON dosyasından 6 ürün okunur', () async {
      TestWidgetsFlutterBinding.ensureInitialized();

      const repository = ProductRepository();
      final products = await repository.getProducts();

      expect(products.length, 6);
      expect(products.first.title, 'Kablosuz Kulaklık');
      expect(products.every((product) => product.price > 0), isTrue);
    });
  });
}
