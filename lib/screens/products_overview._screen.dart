import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFav = false;

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
          actions: [
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFav = true;
                  } else {
                    _showOnlyFav = false;
                  }
                });
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Favorites'),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
              ],
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        body: ProductsGrid(_showOnlyFav),
      ),
    );
  }
}
