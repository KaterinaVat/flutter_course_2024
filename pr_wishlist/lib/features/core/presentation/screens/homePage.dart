import 'package:flutter/material.dart';
import 'package:pr_wishlist/features/core/data/models/Item.dart';
import 'package:pr_wishlist/features/core/data/models/Nomination.dart';
import 'package:pr_wishlist/features/core/domain/addNomination.dart';
import 'package:pr_wishlist/features/core/domain/addItem.dart';
import 'package:pr_wishlist/features/core/presentation/screens/wishListPage.dart';
import 'package:provider/provider.dart';


//главная страница
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nomProvider = Provider.of<NominationModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Мой вишлист'),
        backgroundColor: Colors.red[100],
      ),
      body: Column(
        children: [
          // Сетка с номинациями
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              itemCount: nomProvider.nominations.length,
              itemBuilder: (context, index) {
                final nom = nomProvider.nominations[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistPage(currentNom: nom),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        _buildImage(nom),
                        const SizedBox(height: 8),
                        Text(
                          nom.name,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Кнопка "Я хочу!"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  final newItem = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewItemPage(current_item: null),
                    ),
                  );
                  if (newItem != null) {
                    // Получаем доступ к ItemModel и добавляем новый элемент
                    final itemProvider = Provider.of<ItemModel>(context, listen: false);
                    itemProvider.addItem(newItem);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  "Я хочу!",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ),
          ),
          // Кнопка "Добавить"
          Container(
            color: Colors.amber[50],
            height: 60,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: IconButton(
                    icon: const Icon(Icons.add_circle_rounded),
                    color: Colors.red[100],
                    iconSize: 48.0,
                    onPressed: () async {
                      final newNomination = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewNominationPage(currentNom: null),
                        ),
                      );
                      if (newNomination != null) {
                        nomProvider.addNom(newNomination);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
  // Widget _buildImage(Nomination nom) {
  //   if (nom.imagePath != null && nom.imagePath!.isNotEmpty) {
  //     return Image.network(
  //       nom.imagePath!,
  //       fit: BoxFit.cover,
  //       height: 100,
  //       width: double.infinity,
  //       errorBuilder: (context, error, stackTrace) {
  //         return const Center(
  //           child: Icon(
  //             Icons.broken_image,
  //             size: 80,
  //             color: Colors.grey,
  //           ),
  //         );
  //       },
  //     );
  //   } else if (nom.imageGalery != null) {
  //     return Image.file(
  //       nom.imageGalery!,
  //       fit: BoxFit.cover,
  //       height: 100,
  //       width: double.infinity,
  //     );
  //   } else {
  //     return const Center(
  //       child: Icon(
  //         Icons.image_not_supported,
  //         size: 80,
  //         color: Colors.grey,
  //       ),
  //     );
  //   }
  // }
  Widget _buildImage(Nomination nom) {
    if (nom.imagePath != null && nom.imagePath!.isNotEmpty) {
      return Image.network(
        nom.imagePath!,
        fit: BoxFit.cover,
        height: 100,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Ошибка загрузки изображения: $error'); // Логирование ошибки
          return const Center(
            child: Icon(
              Icons.broken_image,
              size: 80,
              color: Colors.red,
            ),
          );
        },
      );
    } else if (nom.imageGalery != null) {
      return Image.file(
        nom.imageGalery!,
        fit: BoxFit.cover,
        height: 100,
        width: double.infinity,
      );
    } else {
      return const Center(
        child: Icon(
          Icons.image_not_supported,
          size: 80,
          color: Colors.grey,
        ),
      );
    }
  }


}