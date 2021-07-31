import 'package:flutter/material.dart';
import './product.dart';

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

  void addProduct() {
//_items.add(value);
    notifyListeners();
  }
}
