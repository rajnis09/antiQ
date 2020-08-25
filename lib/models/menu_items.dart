import './item_model.dart';

class MenuItem {
  Map<String, List<Item>> menuItems = Map();

  void addMenuItem(
    String categoryName,
    String itemName,
    String description,
    String imageUrl,
    double price,
    bool isVeg,
    List<String> customizablesName,
    List<double> customizablesPrice,
  ) {
    List<Customizables> tempData = [];
    for (int i = 0; i < customizablesName.length; i++) {
      tempData.add(Customizables(customizablesName[i], customizablesPrice[i]));
    }
    if (menuItems.containsKey(categoryName)) {
      menuItems[categoryName].add(Item(
          categoryName: categoryName,
          description: description,
          imageURL: imageUrl,
          isVeg: isVeg,
          itemName: itemName,
          price: price,
          customizables: tempData));
    } else {
      menuItems.putIfAbsent(
        categoryName,
        () => [
          Item(
              categoryName: categoryName,
              description: description,
              imageURL: imageUrl,
              isVeg: isVeg,
              itemName: itemName,
              price: price,
              customizables: tempData)
        ],
      );
    }
    print({"menuItems", menuItems});
  }
}

final MenuItem menuItem = MenuItem();
