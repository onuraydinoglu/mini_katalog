import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/app/app.dart';
import 'package:mini_katalog/features/home/pages/home_page.dart';

void main() {
  testWidgets('Mini Katalog ana sayfa testi', (tester) async {
    await tester.pumpWidget(const MiniKatalogApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Mini Katalog'), findsOneWidget);
    expect(find.text('Öne Çıkan Ürünler'), findsOneWidget);
    expect(find.text('Ürün 1'), findsOneWidget);
  });
}
