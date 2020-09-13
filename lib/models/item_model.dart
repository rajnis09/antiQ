import 'package:flutter/widgets.dart';

class Item {
  // TODO: this should change later
  final UniqueKey itemId;
  final String categoryName;
  final String itemName;
  final String description;
  final String imageURL;
  final double price;
  final bool isVeg;
  final List<Customizables> customizables;
  final List<ItemAvailibilty> differentAvailibility;
  Item({
    this.itemId,
    this.categoryName,
    this.itemName,
    this.description,
    this.imageURL,
    this.isVeg,
    this.price,
    this.customizables,
    this.differentAvailibility,
  });
}

class Customizables {
  String customizableName;
  double customizablePrice;
  Customizables(this.customizableName, this.customizablePrice);
}

class ItemAvailibilty {
  final String type; // gram, plate, pieces etc
  final double quantity;
  final double price;
  ItemAvailibilty(this.type, this.quantity, this.price);

  @override
  String toString() {
    return '$type -> $quantity -> $price';
  }
}
