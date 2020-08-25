class Item {
  final int itemId;
  final String categoryName;
  final String itemName;
  final String description;
  final String imageURL;
  final double price;
  final bool isVeg;
  final List<Customizables> customizables;
  Item({
    this.itemId,
    this.categoryName,
    this.itemName,
    this.description,
    this.imageURL,
    this.isVeg,
    this.price,
    this.customizables,
  });
}

class Customizables {
  String customizableName;
  double customizablePrice;
  Customizables(this.customizableName, this.customizablePrice);
}
