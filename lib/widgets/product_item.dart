import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String? id;
  final String? title;
  final String? imageUrl;
  ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: (id as String));
          },
          child: Image.network(
            (imageUrl as String),
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
          title: Text(
            (title as String),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
