import 'package:flutter/material.dart';
import 'package:food_app/models/food_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<Dish, int> _cartItems = {};

  Map<Dish, int> get items => _cartItems;

  void addToCart(Dish dish) {
    if (_cartItems.containsKey(dish)) {
      _cartItems[dish] = _cartItems[dish]! + 1;
    } else {
      _cartItems[dish] = 1;
    }
    notifyListeners();
  }

  void decreaseQuantity(Dish dish) {
    if (_cartItems.containsKey(dish) && _cartItems[dish]! > 1) {
      _cartItems[dish] = _cartItems[dish]! - 1;
    } else {
      _cartItems.remove(dish);
    }
    notifyListeners();
  }

  int getQuantity(Dish dish) {
    return _cartItems[dish] ?? 0;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
