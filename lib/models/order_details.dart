class OrderDetails {
  int id;
  String time;
  String date;
  String status;
  String ordererName;
  String paymentStatus;
  int totalquantity;
  double totalPrice;
  List<Item> items;

  OrderDetails(
      {this.id,
      this.time,
      this.date,
      this.status,
      this.ordererName,
      this.paymentStatus,
      this.totalquantity,
      this.totalPrice,
      this.items});
}

class Item {
  // int itemId;
  String itemName;
  int itemQuantity;
  double itemPrice;
  // String itemCategoryName;

  Item({
    // this.itemId,
    this.itemName,
    this.itemQuantity,
    this.itemPrice,
    // this.itemCategoryName
  });
}
