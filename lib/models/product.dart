import 'package:restauracja/models/category.dart';
import 'package:restauracja/models/modification.dart';
import 'package:restauracja/models/topping.dart';

class Product {
  final String name;
  final double price;
  final String imageSrc;
  final Category category;
  final List<Topping>? topings;
  final List<Modification>? modifications;

  const Product({
    required this.name,
    required this.price,
    required this.imageSrc,
    required this.category,
    this.topings,
    this.modifications,
  });
}
