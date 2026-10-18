
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/app/app.dart';
import 'package:mini_katalog/features/home/pages/home_page.dart';
import 'package:mini_katalog/features/products/widgets/product_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Mini Katalog ürün listeleme testi', (tester) async {
    await tester.pumpWidget(const MiniKatalogApp());

    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);

    expect(find.text('Mini Katalog'), findsOneWidget);
    expect(find.text('Öne Çıkan Ürünler'), findsOneWidget);

    expect(find.byType(ProductCard), findsWidgets);
    expect(find.text('Kablosuz Kulaklık'), findsOneWidget);
    expect(find.text('Akıllı Saat'), findsOneWidget);
  });
}
