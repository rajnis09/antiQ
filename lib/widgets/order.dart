import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './timer.dart';
import '../models/order_details.dart';
import '../providers/sample_order_data.dart';

class Order extends StatefulWidget {
  Order({Key key, this.order}) : super(key: key);

  final OrderDetails order;
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<Order> {
  bool _hasTimerStopped;
  int _defaultTime;
  OrderDetails _orders;

  @override
  void initState() {
    _orders = widget.order;
    _hasTimerStopped = _orders.remainingTime == 0 ? true : false;
    _defaultTime = 30;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _divider = Divider(
      color: Color(0xFF9E9E9E),
      thickness: .5,
    );

    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.5),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0, 1),
            spreadRadius: 2.0,
            blurRadius: 2.0,
          )
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            upperPart(),
            _divider,
            middlePart(),
            bottomPart(context),
            if (_orders.status != Status.Delivered) animatedButton(),
            SizedBox(
              height: 4,
            )
          ],
        ),
      ),
    );
  }

  Widget upperPart() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(
                "ID : ${_orders.id}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    _orders.time,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) => <PopupMenuItem>[
                      PopupMenuItem(
                        child: InkWell(
                          // splash color
                          onTap: () {
                            print("Call Customer");
                          }, // button pressed
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.call),
                              SizedBox(width: 10),
                              Text("Call Customer"), // text
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: InkWell(
                          // splash color
                          onTap: () {
                            print("Support");
                          }, // button pressed
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.help),
                              SizedBox(width: 10), // icon
                              Text("Support"), // text
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Changed this part and added
  /// [DropDownMenu] for time selection
  Widget middlePart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "1 x Chicken Egg Roll and some extra suases are added",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          /// if [status == NEW] then only
          /// [DropDown] will show
          if (_orders.status == Status.New)
            Row(
              children: <Widget>[
                Text(
                  'Estimated time:\t',
                  style: TextStyle(fontSize: 16),
                ),
                DropdownButton<int>(
                  value: _defaultTime,
                  items: [10, 20, 30, 40, 50, 60]
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text('$e minutes'),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => _defaultTime = value),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget bottomPart(BuildContext context) {
    final theme = Theme.of(context).copyWith(
      dividerColor: Colors.transparent,
    );
    return Container(
      child: Theme(
        data: theme,
        child: ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          tilePadding: EdgeInsets.symmetric(horizontal: 2),
          title: Row(
            children: <Widget>[
              Text(
                "Total Bill : \u20B9 ${_orders.totalPrice}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
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
                    _orders.paymentStatus,
                    style: TextStyle(
                      fontSize: 12,
                      // color:,
                      backgroundColor: Colors.white60,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          children: <Widget>[
            totalitemdetails(),
            ..._orders.items
                .map(
                  (data) => ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    title: itemdetails(
                      data.itemName,
                      data.itemQuantity,
                      data.itemPrice,
                    ),
                  ),
                )
                .toList(),
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

  /// [Order Status] on button can be changed here
  Widget animatedButton() {
    String text = "";
    Color color = (_hasTimerStopped || _orders.remainingTime == 0)
        ? Colors.red
        : Color(0xFF1B98E0);
    Color shadowColor = (_hasTimerStopped || _orders.remainingTime == 0)
        ? Colors.red
        : Color(0xFF40C4FF);
    if (_orders.status == Status.New) {
      text = "Accept Order";
    } else if (_orders.status == Status.Preparing) {
      text = "Order Ready";
    } else if (_orders.status == Status.Ready) {
      text = "Deliver";
      color = Color(0xFF1B98E0);
      shadowColor = Color(0xFF40C4FF);
    }
    return GestureDetector(
      onTap: () {
        final provider = Provider.of<SampleData>(
          context,
          listen: false,
        );
        final status = _orders.status;
        final orderId = _orders.id;

        if (status == Status.New) {
          provider.addToPreparing(orderId, _defaultTime * 60);
        } else if (status == Status.Preparing) {
          provider.addToReady(orderId);
        } else if (status == Status.Ready) {
          provider.addToDelivered(orderId);
        }
      },
      child: Container(
        width: double.infinity,
        height: 40,
        alignment: Alignment.center,
        child: _orders.status == Status.Ready
            ? Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : CountDownTimer(
                orderId: _orders.id,
                text: text,
                seconds: _orders.remainingTime,
                whenTimeExpires: () {
                  setState(() {
                    _hasTimerStopped = true;
                  });
                },
                leftTime: _orders.leftTime,
              ),
        decoration: BoxDecoration(
          /// [RemainingTime == 0 || hasTimerStopped]
          borderRadius: BorderRadius.circular(5),
          color: color,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            ),
          ],
        ),
      ),
    );
  }

  Widget totalitemdetails() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${_orders.totalquantity} item"),
          Text("\u20B9 ${_orders.totalPrice}"),
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
