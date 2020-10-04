// class SellerProfile {
//   String name;
//   String email;
//   String phoneNumber;
//   String imageURL;
// }

// class ShopProfile {
//   String shopId;
//   bool isPolicyAccepted;
//   String shopName;
//   String description;
//   String address;
//   String shopImageURL;
//   // Optional Start
//   String fssaiNumber;
//   String gstInNumber;
//   List<String> menuImageURL;
//   // End
//   List<Item> menuItems;
//   // All orders served by the seller
//   List<OrderDetails> orders;
// }

// class Item {
//   final int itemId;
//   final String categoryName;
//   final String itemName;
//   final String description;
//   final String imageURL;
//   final double price;
//   final bool isVeg;
//   // here quantity denotes the quantites offered by the seller
//   final List<ItemAvailibilty> differentAvailibility;
//   final List<Customizables> customizables;
//   Item({
//     this.itemId,
//     this.categoryName,
//     this.itemName,
//     this.description,
//     this.imageURL,
//     this.isVeg,
//     this.price,
//     this.differentAvailibility,
//     this.customizables,
//   });
// }

// class ItemAvailibilty {
//   final String type; // gram, plate, pieces etc
//   final double quantity;
//   final double price;
//   ItemAvailibilty(this.type, this.quantity, this.price);
// }

// class Customizables {
//   String customizableName;
//   double customizablePrice;
//   Customizables(this.customizableName, this.customizablePrice);
// }

// Single Order
class OrderDetails {
  String id;
  String time;
  String date;
  String status;
  String paymentStatus;
  double totalPrice;
  // List<Item> items;
  List<Quantity> quantities;
  OrderDetails(
      {this.id,
      this.time,
      this.date,
      this.status,
      this.paymentStatus,
      this.totalPrice,
      // this.items
      });
}

// Per ordered quantity
class Quantity {
  // index of the item category availibilty
  // eg 2 * 400 = 800
  // 3 * 200 = 600
  // total = 1400
  int index;
  int numberOfItems;
}
