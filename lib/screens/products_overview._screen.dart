import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
import '../screens/cart_screen.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFav = false;
  final textAdd = '\n'
      'New Items\n'
      'with free shipping\n';
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
            ),
            Consumer<Cart>(
              builder: (_, cartData, ch) => Badge(
                child: ch as Widget,
                value: cartData.itemCount.toString(),
                color: Colors.red,
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed((CartScreen.routeName));
                },
              ),
            ),
          ],
        ),
        body: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(147, 113, 234, 1),
                  const Color.fromRGBO(197, 73, 188, 1),
                  const Color.fromRGBO(215, 131, 79, 1),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1, 0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(21, 40, 75, 1),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(0, -10),
                ),
              ],
            ),
            height: 175,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    textAdd,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        height: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Image.network(
                    'https://freepngimg.com/thumb/shoes/27428-5-nike-shoes-transparent-background.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
          ProductsGrid(_showOnlyFav)
        ]),
      ),
    );
  }
}
