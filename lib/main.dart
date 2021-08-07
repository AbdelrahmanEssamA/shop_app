import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import './screens/products_overview._screen.dart';
import './screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';
import './providers/auth.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products('', [], ''),
            update: (ctx, auth, previousProduct) => Products(
                auth.token as String,
                previousProduct == null ? [] : previousProduct.items,
                auth.userId),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders('', [], ''),
            update: (ctx, auth, previousOrders) => Orders(
                auth.token as String,
                previousOrders == null ? [] : previousOrders.orders,
                auth.userId),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: const Color.fromRGBO(9, 25, 45, 1),
              accentColor: const Color.fromRGBO(3, 14, 33, 1),
            ),
            home:
                auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) =>
                  ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) =>
                  UserProductsScreen(),
              EditProductScreen.routeName: (ctx) =>
                  EditProductScreen(),
            },
          ),
        ));
  }
}
