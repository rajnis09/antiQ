import 'package:flutter/foundation.dart';

import '../models/order_details.dart';

class SampleData with ChangeNotifier {
  final _orders = [
    OrderDetails(
      id: 1749210119,
      date: "2020-08-26",
      time: "7:37 PM",
      ordererName: "Yash Khandelwal",
      status: Status.New,
      remainingTime: 30,
      totalPrice: 125.25,
      totalquantity: 1,
      paymentStatus: "PAID",
      endStatus: "Delivered",
      items: [
        Item(
          itemName: "Chicken Egg Roll",
          itemPrice: 125.25,
          itemQuantity: 1,
        )
      ],
    ),
    OrderDetails(
      id: 1749210107,
      date: "2020-08-26",
      time: "7:35 PM",
      ordererName: "Suraj",
      status: Status.Preparing,
      totalPrice: 125.25,
      remainingTime: 600,
      totalquantity: 1,
      paymentStatus: "PAID",
      endStatus: "Delivered",
      items: [
        Item(
          itemName: "Egg Roll",
          itemPrice: 125.25,
          itemQuantity: 1,
        )
      ],
    ),
    OrderDetails(
      id: 1749210072,
      date: "2020-08-26",
      time: "7:37 PM",
      ordererName: "Rajnish",
      status: Status.Preparing,
      totalPrice: 125.25,
      remainingTime: 600,
      totalquantity: 1,
      paymentStatus: "PAID",
      endStatus: "Cancelled",
      items: [
        Item(
          itemName: "Chicken Egg Roll",
          itemPrice: 125.25,
          itemQuantity: 1,
        )
      ],
    ),
    OrderDetails(
      id: 1749210073,
      date: "2020-08-26",
      time: "7:37 PM",
      ordererName: "Ravi",
      status: Status.Ready,
      totalPrice: 140.25,
      remainingTime: 0,
      totalquantity: 3,
      paymentStatus: "PAID",
      endStatus: "Delivered",
      items: [
        Item(
          itemName: "Chicken Egg Roll",
          itemPrice: 125.25,
          itemQuantity: 1,
        ),
        Item(
          itemName: "Extra Egg",
          itemPrice: 15,
          itemQuantity: 2,
        )
      ],
    ),
    OrderDetails(
      id: 1749210085,
      date: "2020-08-26",
      time: "7:37 PM",
      ordererName: "Sanjeev",
      status: Status.Delivered,
      totalPrice: 130.25,
      remainingTime: 0,
      totalquantity: 1,
      paymentStatus: "PAID",
      endStatus: "Cancelled",
      items: [
        Item(
          itemName: "Chicken Korma Roll",
          itemPrice: 130.25,
          itemQuantity: 1,
        ),
      ],
    ),
  ];
  int _preparing, _ready, _delivered;

  List<OrderDetails> get orders {
    return [..._orders];
  }

  List<OrderDetails> get newOrders {
    final List<OrderDetails> newOrder = [];
    for (OrderDetails order in _orders) {
      if (order.status == Status.New) {
        newOrder.add(order);
      }
    }
    return newOrder;
  }

  List<OrderDetails> get preparing {
    final List<OrderDetails> prep = [];
    for (OrderDetails order in _orders) {
      if (order.status == Status.Preparing) {
        prep.add(order);
      }
    }
    return prep;
  }

  List<OrderDetails> get ready {
    final List<OrderDetails> read = [];
    for (OrderDetails order in _orders) {
      if (order.status == Status.Ready) {
        read.add(order);
      }
    }
    return read;
  }

  List<OrderDetails> get delivered {
    final List<OrderDetails> del = [];
    for (OrderDetails order in _orders) {
      if (order.status == Status.Delivered) {
        del.add(order);
      }
    }
    return del;
  }

  Map<String, int> get counts {
    _preparing = 0;
    _ready = 0;
    _delivered = 0;
    for (OrderDetails order in _orders) {
      if (order.status == Status.Preparing) {
        _preparing++;
      } else if (order.status == Status.Ready) {
        _ready++;
      } else if (order.status == Status.Delivered) {
        _delivered++;
      }
    }
    return {
      'preparing': _preparing,
      'ready': _ready,
      'delivered': _delivered,
    };
  }

  void addToPreparing(int orderId, int remainingTime) {
    _orders.forEach((element) {
      if (element.id == orderId) {
        element.status = Status.Preparing;
        element.remainingTime = remainingTime;
        element.leftTime = DateTime.now();
      }
    });
    notifyListeners();
  }

  void addToReady(int orderId) {
    _orders.forEach((element) {
      if (element.id == orderId) {
        element.status = Status.Ready;
        element.remainingTime = 0;
      }
    });
    notifyListeners();
  }

  void addToDelivered(int orderId) {
    _orders.forEach((element) {
      if (element.id == orderId) {
        element.status = Status.Delivered;
      }
    });
    notifyListeners();
  }

  void updateTimer(int orderId, int remainingTime) {
    _orders.forEach((element) {
      if (element.id == orderId) {
        element.remainingTime = remainingTime;
        element.leftTime = DateTime.now();
      }
    });
  }
}
