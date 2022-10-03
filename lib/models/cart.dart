import 'package:restauracja/models/product.dart';

class Cart extends Product {
  final int quantity;
  final double cost;
  final String comment;

  const Cart(
    this.quantity,
    this.cost,
    this.comment, {
    required super.id,
    required super.name,
    required super.price,
    required super.imageSrc,
    required super.category,
    super.topings,
    super.modifications,
  });
}
