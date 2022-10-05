import 'package:flutter/cupertino.dart';
import 'package:restauracja/models/cart.dart';
import 'package:restauracja/models/orderHistory.dart';

class OrderHistoryProvider extends ChangeNotifier {
  List<OrderHistory> historyProducts = [];

  void addToHistory(List<Cart> products) {
    final DateTime date = DateTime.now();

    for (Cart item in products) {
      final int id = DateTime.now().millisecondsSinceEpoch;
      final OrderHistory product = OrderHistory(
        date: date,
        quantity: item.quantity,
        cost: item.cost,
        comment: item.comment,
        id: id,
        name: item.name,
        price: item.price,
        imageSrc: item.imageSrc,
        category: item.category,
        topings: item.topings.where((element) => element.isSelected).toList(),
        modifications:
            item.modifications.where((element) => element.isSelected).toList(),
      );

      historyProducts.add(product);
    }

    notifyListeners();
  }
}
