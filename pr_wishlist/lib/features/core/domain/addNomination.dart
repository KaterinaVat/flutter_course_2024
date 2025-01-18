import 'package:flutter/material.dart';
import 'package:pr_wishlist/features/core/data/models/Nomination.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

//страничка для запонения новой категории
class NewNominationPage extends StatefulWidget{
  final Nomination? currentNom;
  const NewNominationPage({Key? key, this.currentNom}):super(key:key);
  @override
  State<StatefulWidget> createState() => _NewNominationPage();
}


class _NewNominationPage extends State<NewNominationPage>{
  final _formKey = GlobalKey<FormState>();
  late Nomination _currentNom;
  File? _selectedImage;

  @override
  void initState(){
    super.initState();
    final nominationModel = context.read<NominationModel>();
    final lastIndex = nominationModel.getLastIndex();
    _currentNom=widget.currentNom ?? Nomination(name: 'name', nominationId: lastIndex+1 );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _currentNom.imageGalery = _selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text("Новый вишлист")
        ),
        body:

        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
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
                        Center(
                          child: Text("Изображение не выбрано"),
                        ),
                      const SizedBox(height: 20),

                      // Кнопка для выбора изображения из галереи
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: Icon(Icons.image),
                        label: Text("Выбрать изображение"),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        initialValue: '',
                        decoration: InputDecoration(labelText: "придумай уникальное название!"),
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            //_showErrorSnackbar('Введите название заметки');
                            return '';
                          }
                          return null;
                        },
                        onSaved: (value)=> _currentNom.name=value!,
                      ),
                      TextFormField(
                        initialValue: '',
                        decoration: const InputDecoration(labelText: "добавь ссылку на изображение"),
                        onSaved: (value) {
                          if (value != null && value.isNotEmpty) {
                            _currentNom.imagePath = value;
                          }
                        },
                      ),

                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.pop(context, _currentNom);
                            }
                          },
                          child: Text("Сохранить")),
                    ]
                )

            )
        )


    );
  }
}
