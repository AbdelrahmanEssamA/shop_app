import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProds(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Container(
      color: const Color.fromRGBO(9, 25, 45, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Your Products',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () => _refreshProds(context),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemBuilder: (_, i) => Column(
                children: [
                  UserProductItem(
                      productsData.items[i].id as String,
                      productsData.items[i].title as String,
                      productsData.items[i].imageUrl as String),
                  Divider(
                    color: Colors.white12,
                  )
                ],
              ),
              itemCount: productsData.items.length,
            ),
          ),
        ),
      ),
    );
  }
}
