import 'dart:io';
import 'package:flutter/material.dart';

class Nomination {
  String name;
  String? imagePath;
  int nominationId;
  File? imageGalery;


  Nomination({
    required this.name,
    this.imagePath,
    required this.nominationId,
    this.imageGalery,
  });
}
//интерфейс категории
class NominationModel extends ChangeNotifier {
  final List<Nomination> _nominations = [
    Nomination(
      name: 'День рождения',
      imagePath: "https://pcdn.goldapple.ru/p/p/99000027604/web/696d674d61696e5f37616132383864633061663134343865613231356535663631303836306332378dd146288b42cd3fullhd.webp",
      nominationId: 0,
    ),
    Nomination(
      name: 'Новый год',
      imagePath: 'https://pcdn.goldapple.ru/p/p/19000148354/web/696d674d61696e8dc840183aa223dfullhd.webp',
      nominationId: 1,
    ),
  ];

  List<Nomination> get nominations => _nominations;

  void addNom(Nomination nom) {
    _nominations.add(nom);
    notifyListeners();
  }

  int getLastIndex(){
    return _nominations.length;
  }

  List<Map<String, dynamic>> getAllNominations() {
    return _nominations.map((nom) {
      return {
        'name': nom.name,
        'id': nom.nominationId,
      };
    }).toList();
  }

}