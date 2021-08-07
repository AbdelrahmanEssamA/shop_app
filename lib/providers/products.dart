import 'package:flutter/material.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  final String authToken;
  final String userId;
  List<Product> _items = [];
  Products(this.authToken, this._items, this.userId);
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
        '/products.json', {'auth': '$authToken'});
    var favUrl = Uri.https(
        'rapit-flutter-default-rtdb.firebaseio.com',
        '/$userId.json',
        {'auth': '$authToken'});
    try {
      final res = await http.get(url);

      final extractedData =
          jsonDecode(res.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final favoriteResponse = await http.get(favUrl);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodID, prodData) {
        loadedProducts.add(
          Product(
              id: prodID,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              isFavorite:
                  favoriteData == null || favoriteData[prodID] == null
                      ? false
                      : favoriteData[prodID],
              imageUrl: prodData['imageUrl']),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.https('rapit-flutter-default-rtdb.firebaseio.com',
        '/products.json', {'auth': '$authToken'});
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId
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
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      var url = Uri.https('rapit-flutter-default-rtdb.firebaseio.com',
          '/products/$id.json', {'auth': '$authToken'});
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.https('rapit-flutter-default-rtdb.firebaseio.com',
        '/products/$id.json', {'auth': '$authToken'});
    final existingProductIndex =
        _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
