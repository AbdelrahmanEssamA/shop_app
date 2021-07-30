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
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
        create: (ctx) => loadedProducts[i],
        child: ProductItem(),
      ),
      itemCount: loadedProducts.length,
    );
  }
}
