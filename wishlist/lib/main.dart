import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Мой вишлист'),
        backgroundColor: Colors.red[100],
        actions: [
          Icon(Icons.add)
        ],
      ),
    );
  }
}

void main() {
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (_) => NoteModel(),
  //     child: MyApp(),
  //   ),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мой вишлист',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: homePage(),
    );
  }
}

