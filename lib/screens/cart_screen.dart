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
                    OrderButton(cart: cart)
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading
          ? CircularProgressIndicator(
              color: const Color.fromRGBO(215, 131, 79, 1),
            )
          : Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false)
                  .addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
