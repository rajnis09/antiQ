import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './add_menu_items.dart';
import '../widgets/category_item.dart';
import '../providers/category_items_provider.dart';

class ShopMenuItems extends StatelessWidget {
  ShopMenuItems(this.pageController, this.onEdit);

  final PageController pageController;
  final Function(String) onEdit;

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
                onEdit: onEdit,
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
