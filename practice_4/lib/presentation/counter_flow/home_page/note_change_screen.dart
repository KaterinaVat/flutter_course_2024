import 'package:flutter/material.dart';
import 'package:practice_4/presentation/counter_flow/noteModel.dart';
class NoteDescriptionScreen extends StatefulWidget {
  final Note? currentNote;

  const NoteDescriptionScreen({Key? key, this.currentNote}) : super(key: key);

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteDescriptionScreen> {
  final _formKey = GlobalKey<FormState>(); // Ключ для формы
  late Note _currentNote; // Локальная переменная для редактирования заметки

  @override
  void initState() {
    super.initState();
    // Инициализируем текущую заметку (если передана) или создаём новую
    _currentNote = widget.currentNote ?? Note( '', '');
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currentNote == null ? "Добавить заметку" : "Редактировать заметку"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Привязываем форму к ключу
          child: Column(
            children: [
              TextFormField(
                initialValue: _currentNote.title,
                decoration: InputDecoration(labelText: "Название"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _showErrorSnackbar('Введите название заметки');
                    return '';
                  }
                  return null;
                },
                onSaved: (value) => _currentNote.title = value!,
              ),
              TextFormField(
                initialValue: _currentNote.info,
                decoration: InputDecoration(labelText: "Описание"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _showErrorSnackbar('Введите описание заметки');
                    return '';
                  }
                  return null;
                },
                onSaved: (value) => _currentNote.info = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Если форма валидна, сохраняем данные
                    _formKey.currentState!.save();
                    Navigator.pop(context, _currentNote); // Возвращаем заметку
                  }
                },
                child: Text(widget.currentNote == null ? 'Добавить' : 'Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
