import 'package:flutter/material.dart';
import 'package:restauracja/models/product.dart';

class ProductProvider extends ChangeNotifier {
  final Product product;

  ProductProvider(this.product) {
    clearSelected();
  }

  void clearSelected() {
    product.topings.any((element) => element.isSelected = false);
    product.modifications.any((element) => element.isSelected = false);
  }

  void toggleTopping(int toppingId) {
    final item =
        product.topings.firstWhere((element) => element.id == toppingId);

    item.isSelected = !item.isSelected;
    notifyListeners();
  }

  void toggleModification(int modificationId) {
    final item = product.modifications
        .firstWhere((element) => element.id == modificationId);

    item.isSelected = !item.isSelected;
    notifyListeners();
  }

  int quantity = 1;

  void incrementQuantity() {
    quantity += 1;
    notifyListeners();
  }

  void decrementQuantity() {
    quantity -= 1;
    notifyListeners();
  }

  double get totalCost {
    double toppingPrice = 0;
    double modificationPrice = 0;

    if (product.topings.isNotEmpty) {
      toppingPrice = product.topings
          .where((element) => element.isSelected)
          .fold(0, (previousValue, element) {
        return previousValue + element.price;
      });
    }

    if (product.modifications.isNotEmpty) {
      modificationPrice = product.modifications
          .where((element) => element.isSelected)
          .fold(0, (previousValue, element) {
        return previousValue + element.price;
      });
    }

    return (product.price + toppingPrice + modificationPrice) * quantity;
  }
}
