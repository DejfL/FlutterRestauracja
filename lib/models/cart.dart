import 'package:restauracja/models/product.dart';

class Cart extends Product {
  final int quantity;
  final double cost;
  final String comment;

  const Cart({
    required this.quantity,
    required this.cost,
    required this.comment,
    required super.id,
    required super.name,
    required super.price,
    required super.imageSrc,
    required super.category,
    required super.topings,
    required super.modifications,
  });
}
