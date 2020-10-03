class OrderDetails {
  int id;
  String time;
  String date;
  Status status;
  String ordererName;
  String paymentStatus;
  int totalquantity;
  double totalPrice;
  String endStatus;
  List<Item> items;
  int remainingTime; // in seconds
  DateTime leftTime; // time when user switches TAB

  OrderDetails({
    this.id,
    this.time,
    this.date,
    this.status,
    this.ordererName,
    this.paymentStatus,
    this.totalquantity,
    this.totalPrice,
    this.endStatus,
    this.items,
    this.remainingTime,
    this.leftTime,
  });

  @override
  String toString() {
    return '${this.id}->${this.remainingTime}';
  }
}

class Item {
  // int itemId;
  String itemName;
  int itemQuantity;
  double itemPrice;

  Item({
    // this.itemId,
    this.itemName,
    this.itemQuantity,
    this.itemPrice,
  });
}

enum Status { New, Preparing, Ready, Delivered }
