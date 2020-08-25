import 'package:antiq/providers/category_items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/category_item.dart';
import '../views/menu.dart';
// import './orders.dart';

class Category extends StatelessWidget {
  static const routeName = '/category';

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<CategoryItemsProvider>(context).data;
    return Scaffold(
      appBar: AppBar(
        title: Text('AntiQ'),
      ),
      body: items.length == 0
          ? Center(
              child: Text('You have no items available, start adding some!'),
            )
          : ListView.builder(
              itemBuilder: (_, index) => CategoryItem(
                categoryName: items[index]['categoryName'],
                categoryItems: items[index]['categoryItems'],
              ),
              itemCount: items.length,
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.of(context).pushNamed(AddMenuItems.routeName),
        label: Text('ADD'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
