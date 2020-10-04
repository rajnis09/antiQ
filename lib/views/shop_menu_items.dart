import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../routes/routes.dart';
import '../widgets/category_item.dart';
import '../providers/menu_items_provider.dart';

class ShopMenuItems extends StatelessWidget {
  ShopMenuItems(this.pageController, this.onEdit);

  final PageController pageController;
  final Function(String) onEdit;

  @override
  Widget build(BuildContext context) {
    final menuItems = Provider.of<MenuItemsProvider>(context).menuItems;
    return Scaffold(
      appBar: AppBar(title: Text('AntiQ'), elevation: 0.0),
      body: menuItems == null || menuItems.length == 0
          ? Center(
              child: Text('You have no items available, start adding some!'),
            )
          : ListView.builder(
              itemBuilder: (_, index) {
                String category = menuItems.keys.elementAt(index);
                // print(category);
                return CategoryItem(
                  categoryName: category,
                  categoryItems: menuItems[category],
                  onEdit: onEdit,
                );
              },
              itemCount: menuItems.length,
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pushNamed(Routes.addMenuItems),
        label: Text('ADD'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
