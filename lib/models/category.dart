class Category {
  final int id;
  final String name;
  bool isActive;
  bool get isNotAll {
    if (id != 1) {
      return true;
    } else {
      return false;
    }
  }

  Category(this.id, this.name, {this.isActive = false});
}
