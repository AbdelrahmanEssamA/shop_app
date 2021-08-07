import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productID =
        ModalRoute.of(context)?.settings.arguments as String;
    final loadedProvider =
        Provider.of<Products>(context, listen: false)
            .findById(productID);
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
          title: Text('ElSharmota'),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          margin: EdgeInsets.only(top: 25),
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
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'New Shoes',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                Container(
                  child: Text(
                    loadedProvider.title as String,
                    style:
                        TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Hero(
                    tag: loadedProvider.id as String,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        loadedProvider.imageUrl as String,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    loadedProvider.price.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  child: Text(
                    loadedProvider.description.toString(),
                    style:
                        TextStyle(color: Colors.white, fontSize: 18),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
