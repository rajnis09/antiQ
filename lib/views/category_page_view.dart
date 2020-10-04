import 'package:flutter/material.dart';

import './shop_menu_items.dart';
import './edit_category.dart';

class CategoryPageView extends StatefulWidget {
  @override
  _CategoryPageViewState createState() => _CategoryPageViewState();
}

class _CategoryPageViewState extends State<CategoryPageView> {
  PageController _pageController;
  String _categoryName;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _categoryName = "";
  }

  void onEdit(String category) {
    _pageController.animateToPage(
      1,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      _categoryName = category;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      ShopMenuItems(_pageController, onEdit),
      EditCategory(_pageController, _categoryName),
    ];
    return PageView.builder(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, idx) => pages[idx],
      itemCount: pages.length,
    );
  }
}
