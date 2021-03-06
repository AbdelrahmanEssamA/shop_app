import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final authToken = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: (product.id as String));
          },
          child: Hero(
            tag: product.id as String,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('images/temp.png'),
                image: NetworkImage(
                  (product.imageUrl as String),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(
              product.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: product.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              product.toggleFavoriteStatus(authToken.token as String,
                  authToken.userId as String);
            },
          ),
          title: Text(
            (product.title as String),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id as String,
                  product.price as double, product.title as String);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Item Added to card'),
                action: SnackBarAction(
                  label: 'Undo',
                  textColor: Colors.orange,
                  onPressed: () {
                    cart.removeSingleItem(product.id as String);
                  },
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
