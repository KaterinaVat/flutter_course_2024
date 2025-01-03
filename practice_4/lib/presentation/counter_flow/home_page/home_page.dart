import 'package:flutter/material.dart';
import 'package:practice_4/presentation/counter_flow/noteModel.dart';
import 'package:practice_4/presentation/counter_flow/home_page/note_change_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:practice_4/presentation/counter_flow/noteModel.dart';
import 'package:practice_4/presentation/counter_flow/home_page/note_change_screen.dart';
import 'package:provider/provider.dart';

class AllNotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Мои делишки и заметки"),
      ),
      body: ListView.builder(
        itemCount: noteProvider.notes.length,
        itemBuilder: (context, index) {
          final note = noteProvider.notes[index];
          return Card(
            color: Colors.purple.withOpacity(0.1),
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.info),
              onTap: () async {
                final changedNote = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDescriptionScreen(
                      currentNote: note,
                    ),
                  ),
                );
                if (changedNote != null) {
                  noteProvider.changeNote(changedNote, index);
                }
              },
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  noteProvider.deleteNote(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDescriptionScreen(),
            ),
          );
          if (newNote != null) {
            noteProvider.addNote(newNote);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
