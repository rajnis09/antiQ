class Item {
  final String itemId;
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

  void initialize() {
    print('checking');
  }

  Item.fromMap(Map<String, dynamic> fetchedMap)
      : assert(fetchedMap['customizables'] != null),
        assert(fetchedMap['differentAvailibility'] != null),
        this.categoryName = fetchedMap['categoryName'],
        this.itemId = fetchedMap['itemId'],
        this.itemName = fetchedMap['itemName'],
        this.description = fetchedMap['description'],
        this.imageURL = fetchedMap['imageURL'],
        this.isVeg = fetchedMap['isVeg'],
        this.price = fetchedMap['price'],
        this.customizables = (fetchedMap['customizables'] as List)
            .map((e) => Customizables.fromMap(e))
            .toList(),
        this.differentAvailibility =
            (fetchedMap['differentAvailibility'] as List)
                .map((e) => ItemAvailibilty.fromMap(e))
                .toList();

  Map<String, dynamic> toJson() => {
        'itemId': this.itemId,
        'categoryName': this.categoryName,
        'itemName': this.itemName,
        'description': this.description,
        'imageURL': this.imageURL,
        'isVeg': this.isVeg,
        'price': this.price,
        'customizables': this.customizables.map((e) => e.toJson()).toList(),
        'differentAvailibility':
            this.differentAvailibility.map((e) => e.toJson()).toList()
      };
}

class Customizables {
  final String customizableName;
  final double customizablePrice;
  Customizables(this.customizableName, this.customizablePrice);

  Customizables.fromMap(Map<String, dynamic> fetchedMap)
      : this.customizableName = fetchedMap['customizableName'],
        this.customizablePrice = fetchedMap['customizablePrice'];

  Map<String, dynamic> toJson() => {
        'customizableName': this.customizableName,
        'customizablePrice': this.customizablePrice
      };
}

class ItemAvailibilty {
  final double quantity;
  final String type; // gram, plate, pieces etc
  final double price;
  ItemAvailibilty(this.type, this.quantity, this.price);

  ItemAvailibilty.fromMap(Map<String, dynamic> fetchedMap)
      : this.type = fetchedMap['type'],
        this.quantity = fetchedMap['quantity'],
        this.price = fetchedMap['price'];

  Map<String, dynamic> toJson() =>
      {'type': this.type, 'quantity': this.quantity, 'price': this.price};

  @override
  String toString() {
    return '$type -> $quantity -> $price';
  }
}
