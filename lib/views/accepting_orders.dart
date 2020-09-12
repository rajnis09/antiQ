import 'package:flutter/material.dart';

import '../widgets/orders.dart';
import '../providers/sample_order_data.dart';

class AcceptingOrdersPage extends StatelessWidget {
  final orders = SampleData.fetchAll();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Accepting orders",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                print("Do search your order");
              },
              icon: Icon(Icons.search),
              color: Colors.black,
            )
          ],
          backgroundColor: Colors.white,
          elevation: 3,
          bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.grey[600],
              labelColor: Color(0xFF1B98E0),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.blue,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "All (${orders.length})",
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Prepared(0)",
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Picked(0)",
                      ),
                    ),
                  ),
                ),
                
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Ready(0)",
                      ),
                    ),
                  ),
                ),

                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Delivered(0)",
                      ),
                    ),
                  ),
                ),
              ]),
        ),
        body: TabBarView(children: [
          OrdersPage(),
          Center(child: Text("Prepared")),
          Center(child: Text("Picked")),
          Center(child: Text("Ready")),
          Center(child: Text("Delivered")),
        ]),
      ),
    );
  }
}
