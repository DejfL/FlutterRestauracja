import 'package:flutter/material.dart';
import 'package:restauracja/models/cart.dart';
import 'package:restauracja/models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> products = [];

  void addToCart(Product product, int quantity, double cost, String comment) {
    final int id = DateTime.now().millisecondsSinceEpoch;

    final Cart cart = Cart(
      quantity: quantity,
      cost: cost,
      comment: comment,
      id: id,
      name: product.name,
      price: product.price,
      imageSrc: product.imageSrc,
      category: product.category,
      topings: product.topings.where((element) => element.isSelected).toList(),
      modifications:
          product.modifications.where((element) => element.isSelected).toList(),
    );

    products.add(cart);
    notifyListeners();
  }

  void removeFromCart(Cart cart) {
    products.remove(cart);
    notifyListeners();
  }

  double get totalPrice {
    return products.fold(
        0, (previousValue, element) => previousValue + element.cost);
  }

  void clearCart() {
    products.clear();
    notifyListeners();
  }
}
