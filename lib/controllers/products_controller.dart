import 'package:e_shop/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductsController with ChangeNotifier {
  List<Product> products = [];
  bool isLoading = false;

  getProducts() async {
    try {
      isLoading = true;
      notifyListeners();
      var productsData = await ApiService().fetchProducts();
      products = productsData
          .map((productJson) => Product.fromJson(productJson))
          .toList();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
