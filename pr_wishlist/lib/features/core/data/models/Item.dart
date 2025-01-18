import 'dart:io';
import 'package:flutter/material.dart';

// сама хотелка
class ItemData {
  String name;
  File? imageFile;
  String? imagePath;
  String price;
  String? itemLink;
  int nominationId;
  bool isDone;

  ItemData({
    required this.name,
    this.nominationId=0,
    this.imagePath,
    this.imageFile,
    required this.price,
    this.itemLink,
    this.isDone = false,
  });
}
//интерфейс хотелки
class ItemModel extends ChangeNotifier {
  final List<ItemData> _items = [
    ItemData(
      name: "Парфюм NICOLAI PARFUMEUR",
      nominationId: 0,
      imagePath: 'https://pcdn.goldapple.ru/p/p/19000222749/web/696d674d61696e8dc84097768c0c5fullhd.webp',
      price: '10782',
      itemLink: 'https://goldapple.ru/19000222793-angelys-pear',
    ),
  ];
  List<ItemData> get items => _items;

  void addItem(ItemData item) {
    _items.add(item);
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void toggleItemStatus(ItemData item) {
    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index].isDone = !_items[index].isDone;
      notifyListeners();
    }
  }

  int getLastIndex(){
    return _items.length;
}
}