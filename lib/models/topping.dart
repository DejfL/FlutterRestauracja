class Topping {
  final int id;
  final String name;
  final double price;
  bool isSelected;

  Topping({
    required this.id,
    required this.name,
    required this.price,
    this.isSelected = false,
  });
}
