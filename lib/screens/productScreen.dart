import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/models/product.dart';
import 'package:restauracja/providers/cartProvider.dart';
import 'package:restauracja/providers/productProvider.dart';
import 'package:restauracja/widgets/buttons.dart';
import 'package:restauracja/widgets/textFormField.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductProvider(product),
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: const [
            ProductImage(),
            ProductDescription(),
          ],
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: context.read<ProductProvider>().product.id,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Image.network(
          context.read<ProductProvider>().product.imageSrc,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  const ProductDescription({Key? key}) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  final TextEditingController commentEditingController =
      TextEditingController();

  @override
  void dispose() {
    commentEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.61,
        width: double.infinity,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          productProvider.product.name,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      Text(
                        '${productProvider.product.price.toStringAsFixed(2)} zł',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(fontSize: 25),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraint.maxHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                if (productProvider.product.topings.isNotEmpty)
                                  const Topings(),
                                if (productProvider
                                    .product.modifications.isNotEmpty)
                                  Column(
                                    children: const [
                                      Modification(),
                                      Divider(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                MyTextFormField(
                                  hintText: 'Uwagi',
                                  textEditingController:
                                      commentEditingController,
                                  lines: 4,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const TotalPrice(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Quantity(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: PrimaryButton(
                                        text: 'Zatwierdź',
                                        onClick: () {
                                          _addToCart(context,
                                              commentEditingController.text);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart(BuildContext context, String comment) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    Provider.of<CartProvider>(context, listen: false).addToCart(
      productProvider.product,
      productProvider.quantity,
      productProvider.totalCost,
      comment,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Dodano do koszyka'),
      ),
    );
  }
}

class Topings extends StatelessWidget {
  const Topings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Dodatki:',
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: primaryColor),
        ),
        ...productProvider.product.topings
            .map(
              (e) => SizedBox(
                height: 35,
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  onChanged: (_) {
                    Provider.of<ProductProvider>(context, listen: false)
                        .toggleTopping(e.id);
                  },
                  value: e.isSelected,
                  title: Row(
                    children: [
                      Text(
                        e.name,
                        style: const TextStyle(color: primaryColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '+${e.price.toStringAsFixed(2)} zł',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}

class Modification extends StatelessWidget {
  const Modification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Divider(
          height: 30,
        ),
        Text(
          'Modyfikacje ciasta:',
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: primaryColor),
        ),
        ...productProvider.product.modifications
            .map(
              (e) => SizedBox(
                height: 35,
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  onChanged: (_) {
                    Provider.of<ProductProvider>(context, listen: false)
                        .toggleModification(e.id);
                  },
                  value: e.isSelected,
                  title: Row(
                    children: [
                      Text(
                        e.name,
                        style: const TextStyle(color: primaryColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '+${e.price.toStringAsFixed(2)} zł',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}

class TotalPrice extends StatelessWidget {
  const TotalPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Razem: ',
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: primaryColor),
        ),
        Text(
          '${context.watch<ProductProvider>().totalCost.toStringAsFixed(2)} zł',
          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 25),
        ),
      ],
    );
  }
}

class Quantity extends StatefulWidget {
  const Quantity({Key? key}) : super(key: key);

  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  final TextEditingController quantityEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    quantityEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    quantityEditingController.text = productProvider.quantity.toString();

    return Row(
      children: [
        AddReduceButton.reduce(
          onClick: () {
            Provider.of<ProductProvider>(context, listen: false)
                .decrementQuantity();
          },
          isEnabled: productProvider.quantity > 1 ? true : false,
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 40,
          height: 45,
          child: MyTextFormField(
            textEditingController: quantityEditingController,
            isReadOnly: true,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        AddReduceButton.add(
          onClick: () {
            Provider.of<ProductProvider>(context, listen: false)
                .incrementQuantity();
          },
        ),
      ],
    );
  }
}
