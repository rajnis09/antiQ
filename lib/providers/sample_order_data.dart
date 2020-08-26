import '../models/order_details.dart';

class SampleData {
  static List<OrderDetails> fetchAll() {
    return [
      OrderDetails(
        id: 1749210119,
        date: "2020-08-26",
        time: "7:37 PM",
        ordererName: "Yash Khandelwal",
        status: "Preparing",
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
        status: "Preparing",
        totalPrice: 125.25,
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
        status: "Preparing",
        totalPrice: 125.25,
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
        status: "Preparing",
        totalPrice: 140.25,
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
        status: "Preparing",
        totalPrice: 130.25,
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
  }
}
