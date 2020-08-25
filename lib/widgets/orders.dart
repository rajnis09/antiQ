import 'package:flutter/material.dart';
import '../providers/sample_order_data.dart';
// void main() => runApp(OrdersPage());

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 600),
    );
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    controller.addListener(() {
      // print(timerString);
    });
    super.initState();
  }

  final orders = SampleData.fetchAll();

  @override
  Widget build(BuildContext context) {
    final _divider = Divider(
      color: Color(0xFF9E9E9E),
      thickness: .5,
      // indent: 0,
      // endIndent: 4,
    );

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) => Container(
//         color:Colors.red,
//     margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              // blurRadius: 2.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Container(
          margin: EdgeInsets.all(8.0),
          width: double.infinity,
          // height: 200,
          child: Column(children: [
            upperPart(index),
            _divider,
            middlePart(index),
            // _divider,
            bottomPart(context, index),
            animatedButton(index),
            SizedBox(
              height: 5,
            ),
            _divider,
          ]),
        ),
      ),
    );
  }

  Widget upperPart(int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                "${orders[index].id}",
              ),
            ),
            Container(
                child: Row(children: [
              Text(
                orders[index].time,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              GestureDetector(
                child: Icon(Icons.more_vert),
                onTap: () {
                  print('clicked');
                },
              ),
            ])),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            Container(
              height: 30,
              width: 80,
              // margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  orders[index].status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Color(0xFF1B98E0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF40C4FF),
                    blurRadius: 2.0,
                    // spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              orders[index].ordererName + "1st order",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget middlePart(int index) {
    return Container(
      // height: 30,
      // color:Colors.red,
      alignment: Alignment.centerLeft,
      child: Text(
        "1 x Chicken Egg Roll and some extra suases are added",
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget bottomPart(BuildContext context, int index) {
    bool isExpanded = false;
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Container(
      child: Theme(
        data: theme,
        child: ExpansionTile(
          // backgroundColor: Colors.black,
          expandedAlignment: Alignment.centerLeft,
          // onExpansionChanged: (bool expanding) =>
          //     setState(() => isExpanded = expanding),
          // trailing: Icon(
          //   isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
          //   size: 25.0,
          //   color: isExpanded ? Colors.black : Colors.black,
          // ),
          tilePadding: EdgeInsets.symmetric(horizontal: 2),
          title: Row(
            children: [
              Text(
                "Total Bill : \u20B9 ${orders[index].totalPrice}",
                style: TextStyle(
                    color: isExpanded ? Colors.black : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 20,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    orders[index].paymentStatus,
                    style: TextStyle(
                      fontSize: 12,
                      // color:,
                      backgroundColor: Colors.white60,
                      color: isExpanded ? Colors.black : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          children: [
            totalitemdetails(index),
            ...orders[index]
                .items
                .map((data) => ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    title: itemdetails(
                        data.itemName, data.itemQuantity, data.itemPrice)))
                .toList(),
            // Container(
            //   height:200,
            //   child:ListView.builder(
            //   itemCount: orders[index].items.length,
            //   itemBuilder: (context, index1) {
            //     return ListTile(
            //       title: itemdetails(index, index1),
            //     );
            //   },
            // ),),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "(*Inclusive all Taxes)",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget animatedButton(int index) {
    return Container(
      width: double.infinity,
      height: 40,
      alignment: Alignment.center,
      child: Text(
        "ORDER READY ($timerString)",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFF1B98E0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF40C4FF),
            blurRadius: 2.0,
            // spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          ),
        ],
      ),
    );
  }

  Widget totalitemdetails(int index) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${orders[index].totalquantity} item"),
          Text("\u20B9 ${orders[index].totalPrice}"),
        ],
      ),
    );
  }

  Widget itemdetails(String itemName, int quantity, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              itemName,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              width: 8,
            ),
            Text("x $quantity"),
          ],
        ),
        Text("\u20B9 $price"),
      ],
    );
  }
}
