import 'package:flutter/material.dart';
import 'package:food_app/models/food_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MenuProvider with ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoading = false;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchMenu() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://faheemkodi.github.io/mock-menu-api/menu.json'));

      if (response.statusCode == 200) {
        print('API Response: ${response.body}');
        final Map<String, dynamic> data = json.decode(response.body);

        final List<dynamic> categoriesJson = data['categories'];

        _categories = categoriesJson.map((category) => Category.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load menu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load menu: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}