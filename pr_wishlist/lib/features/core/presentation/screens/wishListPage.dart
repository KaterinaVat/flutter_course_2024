import 'package:flutter/material.dart';
import 'package:pr_wishlist/features/core/data/models/Item.dart';
import 'package:pr_wishlist/features/core/data/models/Nomination.dart';
import 'package:pr_wishlist/features/core/presentation/screens/checkDeteils.dart';
import 'package:provider/provider.dart';


//страница листа
class WishlistPage extends StatelessWidget {
  final Nomination currentNom;

  const WishlistPage({Key? key, required this.currentNom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemModel>(context);
    final filteredItems = itemProvider.items
        .where((item) => item.nominationId == currentNom.nominationId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(currentNom.name),
      ),
      body:
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.75,
        ),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailsPage(currentItem: item),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildImage(item),
                  // if (item.imagePath != null && item.imagePath!.isNotEmpty)
                  //   Expanded(
                  //     child: ClipRRect(
                  //       borderRadius: const BorderRadius.vertical(
                  //         top: Radius.circular(12),
                  //       ),
                  //       child:
                  //
                  //       Image.network(
                  //         item.imagePath!,
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   )
                  // else
                  //   const Expanded(
                  //     child: Icon(
                  //       Icons.image_not_supported,
                  //       size: 80,
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // CheckboxListTile(
                  //   value: item.isDone,
                  //   onChanged: (bool? value) {
                  //     if (value != null) {
                  //       itemProvider.toggleItemStatus(item);
                  //     }
                  //   },
                  // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: item.isDone ? Colors.green : Colors.grey,
                    ),
                    onPressed: () {
                      itemProvider.toggleItemStatus(item); // Используем метод провайдера
                    },
                    child: const Text('Готово!'),
                  ),

                ],
              ),
            ),
          );
        },
      ),

    );
  }
  Widget _buildImage(ItemData item) {
    if (item.imagePath != null && item.imagePath!.isNotEmpty) {
      return Image.network(
        item.imagePath!,
        fit: BoxFit.cover,
        height: 100,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.broken_image,
              size: 80,
              color: Colors.grey,
            ),
          );
        },
      );
    } else if (item.imageFile != null) {
      return Image.file(
        item.imageFile!,
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