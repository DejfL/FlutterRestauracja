import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/models/cart.dart';
import 'package:restauracja/providers/cartProvider.dart';
import 'package:restauracja/widgets/buttons.dart';
import 'package:restauracja/widgets/textFormField.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    cartProvider.addTest();

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
            child: ItemCart(
              cart: cartProvider.products[index],
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
            Expanded(child: PrimaryButton(text: 'Zatwierdź', onClick: () {})),
          ],
        ),
      ),
    );
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

class ItemCart extends StatefulWidget {
  final Cart cart;

  const ItemCart({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.cart.comment);
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        margin: EdgeInsets.zero,
        color: greyColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.cart.imageSrc,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cart.name,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: primaryColor),
                  ),
                  const Divider(
                    height: 8,
                  ),
                  if (widget.cart.topings.isNotEmpty) topings(context),
                  if (widget.cart.modifications.isNotEmpty)
                    modifications(context),
                  if (widget.cart.comment.isNotEmpty)
                    Column(
                      children: [
                        MyTextFormField(
                          textEditingController: textEditingController,
                          isReadOnly: true,
                          lines: 4,
                        ),
                        const Divider(
                          height: 8,
                        ),
                      ],
                    ),
                  summary(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Ilość: ',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: primaryColor),
              ),
              Text(
                widget.cart.quantity.toString(),
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Razem: ',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: primaryColor),
              ),
              Text(
                '${widget.cart.cost.toStringAsFixed(2)} zł',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemName(BuildContext context) {
    return Text(
      widget.cart.name,
      overflow: TextOverflow.fade,
      maxLines: 1,
      softWrap: false,
      style:
          Theme.of(context).textTheme.headline5?.copyWith(color: primaryColor),
    );
  }

  Widget topings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dodatki:',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        ...widget.cart.topings.map(
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
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget modifications(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modifikacje:',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        ...widget.cart.modifications.map(
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
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
