import 'dart:convert';
import 'package:e_shop/models/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Function to fetch product details from API
  Future<List<dynamic>> fetchProducts() async {
    final url = Uri.parse('https://dummyjson.com/products');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        var productsData = json.decode(response.body)["products"] as List;

        // Convert JSON list to list of Product objects
        List<Product> productList = productsData.map((productJson) => Product.fromJson(productJson)).toList();
        return productsData;
      } else {
        // If the server did not return a 200 OK response, throw an exception
        throw Exception('Failed to load details: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print(e.toString());
      throw Exception('Error fetching details: $e');
    }
  }
}
