import 'package:flutter/material.dart';
import 'package:practice_4/presentation/counter_flow/home_page/home_page.dart';
import 'package:provider/provider.dart';
import 'package:practice_4/presentation/counter_flow/noteModel.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
        create: (_) => NoteModel(),
        child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: AllNotePage(),
    );
  }
}

