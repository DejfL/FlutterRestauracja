import 'package:flutter/cupertino.dart';
import 'package:restauracja/models/product.dart';

class ProductProvider extends ChangeNotifier {
  final Product product;

  ProductProvider(this.product);

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

  double get totalPrice {
    double toppingPrice = 0;
    double modificationPrice = 0;

    if (product.topings.isNotEmpty) {
      toppingPrice = product.topings.fold(0, (previousValue, element) {
        if (element.isSelected) {
          return previousValue + element.price;
        } else {
          return 0;
        }
      });
    }

    if (product.modifications.isNotEmpty) {
      modificationPrice =
          product.modifications.fold(0, (previousValue, element) {
        if (element.isSelected) {
          return previousValue + element.price;
        } else {
          return 0;
        }
      });
    }

    return (product.price + toppingPrice + modificationPrice) * quantity;
  }

  void addToCart() {}
}
