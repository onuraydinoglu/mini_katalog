import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/features/products/models/product.dart';

void main() {
  group('WantAPI ürün modeli testleri', () {
    final testJson = <String, dynamic>{
      'id': 1,
      'name': 'iPhone 15 Pro',
      'tagline': 'Titanium. So strong. So light. So Pro.',
      'description': 'Test ürün açıklaması',
      'price': '\$999',
      'currency': 'USD',
      'image': 'https://wantapi.com/assets/images/iphone.png',
      'specs': {'chip': 'A17 Pro', 'material': 'Titanium'},
    };

    test('JSON verisi Product nesnesine dönüşür', () {
      final product = Product.fromJson(testJson);

      expect(product.id, 1);
      expect(product.name, 'iPhone 15 Pro');
      expect(product.price, 999.0);
      expect(product.currency, 'USD');
      expect(product.specs['chip'], 'A17 Pro');
    });

    test('Virgüllü fiyat doğru ayrıştırılır', () {
      final json = Map<String, dynamic>.from(testJson);
      json['price'] = '\$2,499';

      final product = Product.fromJson(json);

      expect(product.price, 2499.0);
    });

    test('Product nesnesi JSON verisine dönüşür', () {
      final product = Product.fromJson(testJson);
      final json = product.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'iPhone 15 Pro');
      expect(json['currency'], 'USD');
      expect(json['specs']['chip'], 'A17 Pro');
      expect(json['price'], '\$999.00');
    });
  });
}
