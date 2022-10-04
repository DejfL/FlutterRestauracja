import 'package:flutter/material.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/models/cart.dart';
import 'package:restauracja/widgets/textFormField.dart';

class ProductItem extends StatefulWidget {
  final item;

  const ProductItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.item.comment);
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
                    widget.item.imageSrc,
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
                    widget.item.name,
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
                  if (widget.item.topings.isNotEmpty) topings(context),
                  if (widget.item.modifications.isNotEmpty)
                    modifications(context),
                  if (widget.item.comment.isNotEmpty)
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
                widget.item.quantity.toString(),
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
                '${widget.item.cost.toStringAsFixed(2)} zł',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          if (widget.item.runtimeType != Cart)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Zamówiono: ',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: primaryColor),
                ),
                Text(
                  widget.item.readableDate,
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
      widget.item.name,
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
        ...widget.item.topings.map(
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
        ...widget.item.modifications.map(
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
