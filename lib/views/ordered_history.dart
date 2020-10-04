import 'package:flutter/material.dart';

import '../providers/sample_order_data.dart';
import '../models/order_details.dart';

class OrderHistory extends StatefulWidget {

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<OrderDetails> item = [];
  List<double> earningPerOrder = [];
  double totalEarnings = 0;
  final orders = SampleData().orders;

  @override
  void initState() {
    var currDate = DateTime.now();
    var todayDate = "${currDate.year}-${currDate.month}-${currDate.day}";
    item = orders.where((item) {
      var date = DateTime.parse(item.date);
      var format = "${date.year}-${date.month}-${date.day}";
      return format == todayDate;
    }).toList();
    for (var i = 0; i < item.length; i++) {
      if (item[i].endStatus == "Delivered") totalEarnings += item[i].totalPrice;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ListTile(
            leading: Text(
              "Total: " + "₹" + totalEarnings.toString(),
            ),
            trailing: Text(
              "Orders: " + item.length.toString(),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "Today's Order",
                style: TextStyle(fontSize: 22, color: Colors.grey),
              ),
              trailing: GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed('/previousHistory'),
                child: Text("Previous Order",
                    style: TextStyle(fontSize: 22, color: Colors.black)),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemBuilder: (context, id) {
                  List<Item> items = item[id].items;
                  String status = item[id].endStatus;
                  // var time = TimeOfDay.fromDateTime(
                  //     DateTime.parse(item[id]["orderedTime"].toString()));
                  return Theme(
                    data: ThemeData.light()
                        .copyWith(dividerColor: Colors.transparent),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                      // width: double.infinity,
                      child: Card(
                          // color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 4,
                          child: ExpansionTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Text(
                                              (id + 1).toString() +
                                                  ". Order ID " +
                                                  item[id].id.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        item[id].date.toString() +
                                            " at " +
                                            // time.format(context).toString(),
                                            item[id].time,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      status == "Delivered"
                                          ? Icons.check_circle_outline
                                          : Icons.cancel,
                                      color: status == "Delivered"
                                          ? Colors.green
                                          : Colors.red,
                                      size: 20,
                                    ),
                                    Container(
                                      child: Text(
                                        "₹" + item[id].totalPrice.toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(
                                    left: 16, top: 0, right: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: status == "Delivered"
                                          ? Colors.green
                                          : Colors.red,
                                      border: Border.all(
                                        color: status == "Delivered"
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 2, bottom: 5),
                                child: Column(children: [
                                  ...items.map(
                                    (e) {
                                      double itemPrice = double.parse(
                                              e.itemQuantity.toString()) *
                                          e.itemPrice;
                                      return ListTile(
                                        leading: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              border: Border.all(
                                                  color: Colors.grey[200]),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            e.itemQuantity.toString() + "x",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ),
                                        title: Text(
                                          e.itemName.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        trailing: Container(
                                          child: Text(
                                            "₹" + itemPrice.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ]),
                              ),
                            ],
                          )),
                    ),
                  );
                },
                itemCount: item.length,
              ),
            ),
          ],
        ));
  }
}
