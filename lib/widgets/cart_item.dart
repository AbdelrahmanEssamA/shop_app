import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productID;
  final double price;
  final int quantity;
  final String title;

  CartItem(
      this.id, this.title, this.price, this.quantity, this.productID);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false)
            .removeItem(productID);
      },
      child: Card(
        elevation: 5,
        color: const Color.fromRGBO(18, 38, 81, .9),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(
                    child: Text(
                  price.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            subtitle: Text(
              'Total: \$${(price * quantity)}',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              '$quantity X',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
