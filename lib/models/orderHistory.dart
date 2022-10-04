import 'package:intl/intl.dart';
import 'package:restauracja/models/cart.dart';

class OrderHistory extends Cart {
  final DateTime date;
  String get readableDate {
    var outputFormat = DateFormat('dd-MM-yyyy');
    return outputFormat.format(date);
  }

  const OrderHistory({
    required this.date,
    required super.quantity,
    required super.cost,
    required super.comment,
    required super.id,
    required super.name,
    required super.price,
    required super.imageSrc,
    required super.category,
    required super.topings,
    required super.modifications,
  });
}
