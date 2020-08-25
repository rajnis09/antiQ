import 'package:flutter/material.dart';
import '../widgets/orders.dart';

class AcceptingOrdersPage extends StatefulWidget {
  @override
  _AcceptingOrdersPageState createState() => _AcceptingOrdersPageState();
}

class _AcceptingOrdersPageState extends State<AcceptingOrdersPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return MaterialApp(
      home: SafeArea(
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

            labelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            indicatorColor: Colors.red,
            // indicator: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Colors.redAccent),
            tabs: [
              Tab(
                child: Container(
                  // color:  _tabController.index == 0 ?Colors.blueAccent:Colors.white,
                  // width: size.width * .25,
                  height: size.height * .06,
                  decoration: BoxDecoration(
                    color:
                        _tabController.index == 0 ? Colors.redAccent: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(
                    //   color: _tabController.index == 0
                    //       ? Colors.redAccent
                    //       : Colors.grey,
                    //   width: 1,
                    // ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "All(0)",
                        style: TextStyle(
                            fontWeight: _tabController.index == 0
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  // color:Colors.blue,
                  // width: size.width * .2,
                  height: size.height * .06,
                  decoration: BoxDecoration(
                    color:
                        _tabController.index == 1 ? Colors.redAccent: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(
                    //   color: _tabController.index == 0
                    //       ? Colors.redAccent
                    //       : Colors.grey,
                    //   width: 1,
                    // ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Preparing(0)",
                        style: TextStyle(
                            fontWeight: _tabController.index == 1
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  // width: size.width * .25,
                  height: size.height * .06,
                  decoration: BoxDecoration(
                    color:
                        _tabController.index == 2 ? Colors.redAccent: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(
                    //   color: _tabController.index == 0
                    //       ? Colors.redAccent
                    //       : Colors.grey,
                    //   width: 1,
                    // ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Picked(0)",
                        style: TextStyle(
                            fontWeight: _tabController.index == 2
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  // width: size.width * .25,
                  height: size.height * .06,
                  decoration: BoxDecoration(
                    color:
                        _tabController.index == 3 ? Colors.redAccent: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(
                    //   color: _tabController.index == 0
                    //       ? Colors.redAccent
                    //       : Colors.grey,
                    //   width: 1,
                    // ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Ready(0)",
                        style: TextStyle(
                            fontWeight: _tabController.index == 3
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            OrdersPage(),
            Center(child: Text("Prepared")),
            Center(child: Text("Picked")),
            Center(child: Text("Ready")),
          ],
        ),
      )),
    );
  }
}
