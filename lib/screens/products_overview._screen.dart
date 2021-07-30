import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(3, 14, 33, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Rap It',
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: products_grid(),
      ),
    );
  }
}
