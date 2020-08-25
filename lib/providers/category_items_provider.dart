import 'package:flutter/foundation.dart';

import '../models/item_model.dart';

class CategoryItemsProvider extends ChangeNotifier {
  final List<Map<String, Object>> _localData = [
    // {
    //   'categoryName': 'categoryName',
    //   'categoryItems': [
    //     Item(),
    //     Item(),
    //     Item(),
    //   ]
    // }
  ];

  List<Map<String, Object>> get data {
    return [..._localData];
  }

  Future<bool> addItem(Item item) {
    var present = false;
    var index = 0;
    _localData.forEach((value) {
      if (value['categoryName'] == item.categoryName) {
        present = true;
      } else if (!present) {
        index++;
      }
    });

    if (_localData.length == 0) {
      _localData.insert(0, {
        'categoryName': item.categoryName,
        'categoryItems': [item]
      });
    } else if (!present) {
      _localData.insert(0, {
        'categoryName': item.categoryName,
        'categoryItems': [item]
      });
    } else {
      (_localData[index]['categoryItems'] as List).add(item);
    }

    notifyListeners();
    return Future.value(true);
  }
}
