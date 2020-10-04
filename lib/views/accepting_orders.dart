import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './tabs/all.dart';
import './tabs/preparing.dart';
import './tabs/ready.dart';
import './tabs/delivered.dart';
import '../providers/sample_order_data.dart';

class AcceptingOrdersPage extends StatefulWidget {
  // final orders = SampleData.fetchAll();
  @override
  _AcceptingOrdersPageState createState() => _AcceptingOrdersPageState();
}

class _AcceptingOrdersPageState extends State<AcceptingOrdersPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SampleData>(context);
    final counts = provider.counts;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Accepting orders",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
          controller: _controller,
          isScrollable: true,
          unselectedLabelColor: Colors.grey[600],
          labelColor: Color(0xFF1B98E0),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.blue,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          tabs: <TabWidget>[
            TabWidget(
              title: "All",
            ),
            TabWidget(
              title: "Preparing (${counts['preparing']})",
            ),
            TabWidget(
              title: "Ready (${counts['ready']})",
            ),
            TabWidget(
              title: "Delivered (${counts['delivered']})",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          AllOrders(_controller),
          Preparing(),
          Ready(),
          Delivered(),
        ],
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  const TabWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
