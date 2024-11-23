import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practice_4/presentation/notes_flow/notes_model.dart';
import 'package:practice_4/presentation/notes_flow/notes_list/notes_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NotesModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NotesListScreen(),
    );
  }
}