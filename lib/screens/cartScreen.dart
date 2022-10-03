import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/models/cart.dart';
import 'package:restauracja/providers/cartProvider.dart';
import 'package:restauracja/screens/productScreen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    cartProvider.addTest();

    return ListView.builder(
      itemCount: cartProvider.products.length,
      itemBuilder: (context, index) {
        return ItemCart(
          cart: cartProvider.products[index],
        );
      },
    );
  }
}

class ItemCart extends StatelessWidget {
  final Cart cart;

  const ItemCart({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: primaryColor,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    cart.imageSrc,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      top: 5,
                      right: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        itemName(context),
                        const Divider(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (cart.topings.isNotEmpty) Topings(context),
                          if (cart.modifications.isNotEmpty)
                            Modifications(context),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        'Razem: ',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemName(BuildContext context) {
    return Text(
      cart.name,
      overflow: TextOverflow.fade,
      maxLines: 1,
      softWrap: false,
      style:
          Theme.of(context).textTheme.headline5?.copyWith(color: primaryColor),
    );
  }

  Widget Topings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        top: 5,
        right: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dodatki:',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          ...cart.topings.map(
            (e) => Row(
              children: [
                Text(
                  e.name,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  '+${e.price.toStringAsFixed(2)} zł',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Modifications(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        top: 5,
        right: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Modifikacje:',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          ...cart.modifications.map(
            (e) => Row(
              children: [
                Text(
                  e.name,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  '+${e.price.toStringAsFixed(2)} zł',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
