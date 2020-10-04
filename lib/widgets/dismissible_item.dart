import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './item_unit.dart';
import './all_Alert_Dialogs.dart';
import '../models/item_model.dart';
import '../providers/menu_items_provider.dart';

class DismissibleItem extends StatelessWidget {
  const DismissibleItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuItemsProvider>(context);
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) {
        return confirmDeleteDialog(context).then((value) {
          if (value) {
            provider.deleteMenuItem(item.itemId, item.categoryName);
            return true;
          }
          return false;
        });
      },
      background: Container(
        child: Text(
          'DELETE',
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.end,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.red,
        ),
      ),
      child: ItemUnit(
        itemName: item.itemName,
        imageURL: item.imageURL,
        price: item.price,
        isVeg: item.isVeg,
        customizables: item.customizables,
      ),
    );
  }
}
