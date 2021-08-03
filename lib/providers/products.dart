import 'package:flutter/material.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: 'p1',
        title: 'Air Force',
        description: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl:
            'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/5e1b2266-e664-4ddc-ae5e-511453bb5b6b/air-max-270-g-golf-shoe-qdKfmN.png'),
    Product(
      id: 'p2',
      title: 'Air Jordans Teal',
      description: 'Teal Air jordans limited Edition',
      price: 59.99,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0255/9429/8467/products/jordan-1-mid-tropical-twist-554724-132_1_rssk4q_1800x1800.jpg?v=1620130039',
    ),
    Product(
      id: 'p3',
      title: 'Jordans',
      description: 'Warm and cozy - Pair of jordans',
      price: 19.99,
      imageUrl:
          'https://sneakernews.com/wp-content/uploads/2021/04/Air-Jordan-1-Shadow-2.0-555088-035-2.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Air Force',
      description: 'Nike Air',
      price: 49.99,
      imageUrl:
          'https://static.nike.com/a/images/f_auto/dpr_3.0/h_500,c_limit/airli0aepmuyh9hxduns/nike-air-max-air-max-day-2020.jpg',
    ),
  ];

  var _showFavoritesOnly = false;
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    var url = Uri.https('rapit-flutter-default-rtdb.firebaseio.com',
        '/products.json');
    try {
      final res = await http.get(url);
      print(res.body);
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.https('rapit-flutter-default-rtdb.firebaseio.com',
        '/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
