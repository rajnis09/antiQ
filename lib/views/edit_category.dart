import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/dismissible_item.dart';
import '../providers/category_items_provider.dart';

class EditCategory extends StatelessWidget {
  EditCategory(this.pageController, this.categoryName);

  final PageController pageController;
  final String categoryName;

  Future<bool> pop() {
    pageController.animateToPage(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final items =
        Provider.of<CategoryItemsProvider>(context).getByCategory(categoryName);
    // final items = data['categoryItems'] as List;

    if (items.length == 0) {
      pop();
    }

    var appBar = AppBar(
      title: Text('Edit $categoryName'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: pop,
      ),
    );
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
        appBar: appBar,
        body: ListView.builder(
          itemBuilder: (_, idx) => DismissibleItem(
            item: items[idx],
          ),
          itemCount: items.length,
        ),
      ),
    );
  }
}
