import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauracja/providers/orderHistoryProvider.dart';
import 'package:restauracja/widgets/productItem.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderHistoryProvider = context.watch<OrderHistoryProvider>();

    if (orderHistoryProvider.historyProducts.isEmpty) {
      return Center(
        child: Text(
          'Twój historia jest pusta',
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
      );
    }

    return historyItems(orderHistoryProvider);
  }

  Widget historyItems(OrderHistoryProvider orderHistoryProvider) {
    return ListView.builder(
      itemCount: orderHistoryProvider.historyProducts.length,
      itemBuilder: (context, index) {
        return ProductItem(
          item: orderHistoryProvider.historyProducts[index],
        );
      },
    );
  }
}
