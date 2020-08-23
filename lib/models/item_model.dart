class Item {
  // int itemId;
  final String categoryName;
  final String itemName;
  final String description;
  final String imageUrl;
  final double price;
  final bool isVeg;
  final List<Customizables> customizables;
  Item(
      {this.categoryName,
      this.itemName,
      this.description,
      this.imageUrl,
      this.isVeg,
      this.price,
      this.customizables});
}

class Customizables {
  String customizableName;
  double customizablePrice;
  Customizables(this.customizableName, this.customizablePrice);
}
