import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/helpers/emailSettings.dart';
import 'package:restauracja/helpers/sendOrderEmail.dart';
import 'package:restauracja/providers/cartProvider.dart';
import 'package:restauracja/providers/orderHistoryProvider.dart';
import 'package:restauracja/widgets/buttons.dart';
import 'package:restauracja/widgets/productItem.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    // cartProvider.addTest();

    if (cartProvider.products.isEmpty) {
      return Center(
        child: Text(
          'Twój koszyk jest pusty',
          style: Theme.of(context).textTheme.headline4,
        ),
      );
    }

    return Column(
      children: [
        cartItems(cartProvider),
        summaryAndConfirm(context),
      ],
    );
  }

  Expanded cartItems(CartProvider cartProvider) {
    return Expanded(
      child: ListView.builder(
        itemCount: cartProvider.products.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(
              cartProvider.products[index].id,
            ),
            onDismissed: (direction) {
              if (DismissDirection.endToStart == direction) {
                Provider.of<CartProvider>(context, listen: false)
                    .removeFromCart(cartProvider.products[index]);
              }
            },
            background: backGround(context),
            child: ProductItem(
              item: cartProvider.products[index],
            ),
          );
        },
      ),
    );
  }

  Widget summaryAndConfirm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: primaryColor,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Suma: ',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: primaryColor),
                ),
                Text(
                  '${context.watch<CartProvider>().totalPrice.toStringAsFixed(2)} zł',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: PrimaryButton(
                text: 'Zatwierdź',
                onClick: () {
                  _confirm(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirm(BuildContext context) async {
    final productProvider = Provider.of<CartProvider>(context, listen: false);
    Provider.of<OrderHistoryProvider>(context, listen: false)
        .addToHistory(productProvider.products);

    if (await emailSettingsExist()) {
      await sednOrderEmail(
          productProvider.products, productProvider.totalPrice);
    }

    productProvider.clearCart();
  }

  Padding backGround(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13, top: 13, bottom: 13),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(
              10,
            ),
            bottomRight: Radius.circular(
              10,
            ),
          ),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: 30,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }
}
