import 'package:flutter/material.dart';
import 'package:pr_wishlist/features/core/data/models/Item.dart';
import 'package:pr_wishlist/features/core/data/models/Nomination.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


//создание новой хотелки
class NewItemPage extends StatefulWidget{
  final ItemData? current_item;
  const NewItemPage({Key? key, this.current_item}):super(key:key);
  @override
  _NewItemPage createState() => _NewItemPage();
}

class _NewItemPage extends State<NewItemPage> {
  final _formKey = GlobalKey<FormState>();
  late ItemData _currentItem = ItemData(name: "", nominationId: 0, price: '', isDone: false);
  File? _selectedImage;
  String? _selectedCategory; // Хранит выбранную категорию
  late List<Map<String, dynamic>> _categories; // Список категорий

  @override
  void initState() {
    super.initState();
    final nominationModel = context.read<NominationModel>();
    _categories = nominationModel.getAllNominations();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _currentItem.imageFile = _selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Я желаю...")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_selectedImage != null)
                  Center(
                    child: Image.file(
                      _selectedImage!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  const Center(child: Text("Изображение не выбрано")),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text("Выбрать изображение"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(labelText: "О чем ты мечтаешь?"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите название';
                    }
                    return null;
                  },
                  onSaved: (value) => _currentItem.name = value!,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(labelText: "Добавь ссылку на изображение"),
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      _currentItem.imagePath = value;
                    }
                  },
                ),
                const SizedBox(height: 20),

                // Выпадающий список для выбора категории
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category['name'], // Используем имя категории
                      child: Text(category['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: "Выберите категорию"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, выберите категорию';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    final selectedCategory = _categories.firstWhere(
                          (category) => category['name'] == value,
                    );
                    _currentItem.nominationId = selectedCategory['id']; // Записываем ID категории
                  },
                ),

                const SizedBox(height: 20),
                TextFormField(
                  initialValue: '',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: "Стоимость (в рублях)"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите стоимость';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Введите корректное число';
                    }
                    return null;
                  },
                  onSaved: (value) => _currentItem.price = value!,
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pop(context, _currentItem); // Возвращаем весь объект
                    }
                  },
                  child: const Text("Сохранить"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
