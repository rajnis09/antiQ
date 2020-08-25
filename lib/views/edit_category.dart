import 'package:flutter/material.dart';

import '../widgets/dismissible_item.dart';

class EditCategory extends StatefulWidget {
  static const routeName = "editCategory";

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final title = data['categoryName'];
    final items = data['categoryItems'] as List;

    var appBar = AppBar(
      title: Text('Category Edit'),
    );
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          LimitedBox(
            maxHeight: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            height: mediaQuery.size.height -
                appBar.preferredSize.height -
                50 -
                mediaQuery.padding.top,
            child: ListView.builder(
              itemBuilder: (_, idx) => DismissibleItem(
                item: items[idx],
              ),
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}
