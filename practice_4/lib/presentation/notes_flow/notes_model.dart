import 'package:flutter/material.dart';

class Note {
  String title;
  String text;

  Note(this.title, this.text);
}

class NotesModel extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(int index, Note note) {
    _notes[index] = note;
    notifyListeners();
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}