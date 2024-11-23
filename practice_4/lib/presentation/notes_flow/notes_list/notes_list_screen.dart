import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practice_4/presentation/notes_flow/notes_model.dart';
import 'package:practice_4/presentation/notes_flow/note_detail/note_detail_screen.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Consumer<NotesModel>(
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.notes.length,
            itemBuilder: (context, index) {
              final note = model.notes[index];
              return ListTile(
                title: Text(note.title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NoteDetailScreen(index: index),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final model = Provider.of<NotesModel>(context, listen: false);
          model.addNote(Note('', ''));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NoteDetailScreen(index: model.notes.length - 1),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}