import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../providers/order.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
      color: const Color.fromRGBO(3, 14, 33, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Your Cart'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25),
              height: 250,
              child: Image.network(
                'https://www.totallymoney.com/credit-cards/public/img/creditcards-hero.png',
                fit: BoxFit.cover,
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        cart.totalAmount.toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                      backgroundColor:
                          const Color.fromRGBO(147, 113, 234, 1),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      child: Text('Order Now'),
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false)
                            .addOrder(cart.items.values.toList(),
                                cart.totalAmount);
                        cart.clearCart();
                      },
                      style: TextButton.styleFrom(
                        primary:
                            const Color.fromRGBO(147, 113, 234, 1),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (ctx, i) => CartItem(
                  cart.items.values.toList()[i].id as String,
                  cart.items.values.toList()[i].title as String,
                  cart.items.values.toList()[i].price as double,
                  cart.items.values.toList()[i].quantity as int,
                  cart.items.keys.toList()[i]),
              itemCount: cart.itemCount,
            ))
          ],
        ),
      ),
    );
  }
}
