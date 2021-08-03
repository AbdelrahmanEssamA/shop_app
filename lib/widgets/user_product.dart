import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      EditProductScreen.routeName,
                      arguments: id);
                },
                icon: Icon(Icons.edit),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Provider.of<Products>(context , listen: false)
                      .deleteProduct(id);
                },
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
