import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class products_grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15),
      itemBuilder: (ctx, i) => ProductItem(loadedProducts[i].id,
          loadedProducts[i].title, loadedProducts[i].imageUrl),
      itemCount: loadedProducts.length,
    );
  }
}
