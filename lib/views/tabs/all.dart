import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/sample_order_data.dart';
import '../../widgets/order.dart';

class AllOrders extends StatelessWidget {
  AllOrders(this.controller);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SampleData>(context);
    final counts = provider.counts;
    final orders = provider.newOrders;
    final fixed = [
      drawTabs('Preparing', counts['preparing'], 1),
      drawTabs('Ready', counts['ready'], 2),
      drawTabs('Delivered', counts['delivered'], 3)
    ];
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        Widget widget;
        if (idx < orders.length) {
          widget = Order(
            key: ValueKey(orders[idx].id),
            order: orders[idx],
          );
        } else {
          widget = fixed[idx - orders.length];
        }
        return widget;
      },
      itemCount: orders.length + fixed.length,
    );
  }

  Widget drawTabs(String title, int current, int index) => ListTile(
        title: Text('$title ($current)'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => controller.animateTo(index),
      );
}
