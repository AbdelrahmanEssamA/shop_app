import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProvider =
        Provider.of<Products>(context, listen: false).findById(productID);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromRGBO(147, 113, 234, 1),
            const Color.fromRGBO(197, 73, 188, 1),
            const Color.fromRGBO(215, 131, 79, 1),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1, 0.2),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(loadedProvider.title as String),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 70),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(4, 14, 34, .7),
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(0, -10),
              ),
            ],
            color: const Color.fromRGBO(4, 14, 34, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
        ),
      ),
    );
  }
}
