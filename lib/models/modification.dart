class Modification {
  final int id;
  final String name;
  final double price;
  bool isSelected;

  Modification({
    required this.id,
    required this.name,
    required this.price,
    this.isSelected = false,
  });
}
