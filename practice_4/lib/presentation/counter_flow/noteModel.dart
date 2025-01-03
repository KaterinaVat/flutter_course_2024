import 'package:flutter/cupertino.dart';

class Note {
  String title;
  String info;

  Note(this.title, this.info);
}

class NoteModel with ChangeNotifier {
  final List<Note> _notes = [
    Note('Заметка 1', 'Описание для заметки 1'),
    Note('Заметка 2', 'Описание для заметки 2'),
  ];

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void changeNote(Note note, int index) {
    _notes[index] = note;
    notifyListeners();
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}
