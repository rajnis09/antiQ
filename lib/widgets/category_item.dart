import 'package:flutter/material.dart';

import 'item_unit.dart';
import '../models/item_model.dart';
import './icon_label_button.dart';
import '../views/edit_category.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({
    Key key,
    @required this.categoryName,
    @required this.categoryItems,
  }) : super(key: key);

  final String categoryName;
  final List<Item> categoryItems;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          categoryName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: IconLabelButton(
          icon: Icons.edit,
          label: 'Edit',
          onPressed: () => Navigator.of(context).pushNamed(
            EditCategory.routeName,
            arguments: {
              'categoryName': categoryName,
              'categoryItems': categoryItems,
            },
          ),
          color: Colors.blue,
        ),
        children: categoryItems
            .map(
              (item) => ItemUnit(
                itemName: item.itemName,
                price: item.price,
                imageURL: item.imageURL,
                isVeg: item.isVeg,
                customizables: item.customizables,
              ),
            )
            .toList(),
      ),
    );
  }
}
