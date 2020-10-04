import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/sample_order_data.dart';
import '../../widgets/order.dart';

class Ready extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<SampleData>(context).ready;
    return orders.length == 0
        ? Center(
            child: Text(
              'No orders found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, idx) => Order(
              key: ValueKey(orders[idx].id),
              order: orders[idx],
            ),
            itemCount: orders.length,
          );
  }
}
