import 'package:flutter/material.dart';
import 'package:pr_wishlist/features/core/data/models/Item.dart';
import 'package:pr_wishlist/features/core/data/models/Nomination.dart';
import 'package:pr_wishlist/features/core/presentation/screens/homePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NominationModel()),
        ChangeNotifierProvider(create: (_) => ItemModel()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мой вишлист',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
