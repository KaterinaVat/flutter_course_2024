import 'package:flutter/material.dart';
import 'package:pr_wishlist/features/core/data/models/Item.dart';
import 'package:google_fonts/google_fonts.dart';


//красивый просмотр хотелки
class ItemDetailsPage extends StatefulWidget {
  final ItemData? currentItem;

  const ItemDetailsPage({Key? key, this.currentItem}) : super(key: key);

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}
class _ItemDetailsPageState extends State<ItemDetailsPage> {
  late ItemData _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.currentItem ??
        ItemData(name: '', nominationId: 0, price: '', isDone: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Мое желание...",
          style: GoogleFonts.greatVibes(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Изображение товара
            _buildImage(_currentItem),
            const SizedBox(height: 20),

            // Каллиграфический текст: "Я бы очень хотела (название)"
            Text(
              "Я бы очень хотела\n${_currentItem.name}",
              style: GoogleFonts.delius(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),


            // Каллиграфический текст: "Стоимость: (цена)"
            Text(
              "Стоимость: ${_currentItem.price} руб.",
              style: GoogleFonts.delius(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Метод для отображения изображения
  Widget _buildImage(ItemData item) {
    if (item.imagePath != null && item.imagePath!.isNotEmpty) {
      return Image.network(
        item.imagePath!,
        fit: BoxFit.cover,
        height: 200,
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
        height: 200,
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
