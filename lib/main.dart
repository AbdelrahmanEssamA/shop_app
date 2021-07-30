import 'package:flutter/material.dart';
import './screens/products_overview._screen.dart';
import './screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(9, 25, 45, 1),
          accentColor: const Color.fromRGBO(3, 14, 33, 1),
        ),
        home: ProductsOverviewScreen(),
        routes: {ProductDetailScreen.routeName: (ctx) => ProductDetailScreen()},
      ),
    );
  }
}
