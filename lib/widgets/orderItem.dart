import 'package:flutter/material.dart';
import '../providers/order.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded
          ? min(widget.order.products.length * 20.0 + 140, 300)
          : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(widget.order.amount.toString()),
              subtitle: Text(
                DateFormat('dd/MM/yyy hh:mm')
                    .format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded
                    ? Icons.expand_less
                    : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _expanded
                  ? min(widget.order.products.length * 20.0 + 25, 180)
                  : 0,
              padding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: ListView(
                children: widget.order.products
                    .map(
                      (p) => Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            p.title as String,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${p.quantity}x \$${p.price}',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
