import 'package:flutter/material.dart';
import 'package:mini_katalog/app/theme/app_theme.dart';
import 'package:mini_katalog/features/home/pages/home_page.dart';

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
