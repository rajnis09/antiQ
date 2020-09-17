import 'package:flutter/material.dart';

import '../utils/theme/theme_data.dart';
import './accepting_orders.dart';
import './more.dart';
import './category_page_view.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      AcceptingOrdersPage(),
      CategoryPageView(),
      More(),
    ];

    return Scaffold(
      // appBar: _selectedPageIndex != 1
      //     ? AppBar(
      //         title: Text(_titles[_selectedPageIndex]),
      //         actions: <Widget>[
      //           Padding(
      //             padding: EdgeInsets.only(right: 10.0),
      //             child: GestureDetector(
      //               onTap: null,
      //               child: Icon(
      //                 Icons.notifications_none,
      //                 size: 25,
      //               ),
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(right: 10.0),
      //             child: GestureDetector(
      //               onTap: null,
      //               child: Icon(
      //                 Icons.shopping_cart,
      //                 size: 25,
      //               ),
      //             ),
      //           ),
      //         ],
      //       )
      //     : null,
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: _FABBottomAppBar(
        selectedColor:
            _selectedPageIndex == 4 ? null : CustomThemeData.blueColorShade1,
        onTabSelected: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: [
          _FABBottomAppBarItem(
            iconData: Icons.fastfood,
            text: 'Orders',
          ),
          _FABBottomAppBarItem(
            iconData: Icons.restaurant_menu,
            text: 'Menu',
          ),
          _FABBottomAppBarItem(
            iconData: Icons.menu,
            text: 'More',
          ),
        ],
      ),
    );
  }
}

class _FABBottomAppBarItem {
  _FABBottomAppBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}

class _FABBottomAppBar extends StatefulWidget {
  _FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 3);
  }
  final List<_FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => _FABBottomAppBarState();
}

class _FABBottomAppBarState extends State<_FABBottomAppBar> {
  int _selectedIndex = 0;

  void _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildTabItem({
    _FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  item.iconData,
                  color: color,
                  size: widget.iconSize,
                ),
                Text(
                  item.text,
                  style: CustomThemeData.robotoFont.copyWith(
                    color: CustomThemeData.blackColorShade1,
                  ),
                  textScaleFactor: 1.01,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
