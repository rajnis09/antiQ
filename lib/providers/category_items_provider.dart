import 'package:flutter/widgets.dart';
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

  List<Item> getByCategory(String category) {
    var present = false;
    for (var item in _localData) {
      if (item['categoryName'] == category) {
        present = true;
        break;
      }
    }

    if (present)
      return _localData.firstWhere(
          (element) => element['categoryName'] == category)['categoryItems'];

    return [];
  }

  // int getLengthByCategory(String category) {
  //   var present = false;
  //   for (var item in _localData) {
  //     if (item['categoryName'] == category) {
  //       present = true;
  //       break;
  //     }
  //   }

  //   if (present)
  //     return (_localData.firstWhere((element) =>
  //             element['categoryName'] == category)['categoryItems'] as List)
  //         .length;

  //   return 0;
  // }

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

  Future<bool> changePrice(String categoryName, int itemId, double newPrice) {
    print(newPrice);
    for (int i = 0; i < _localData.length; i++) {
      if (_localData[i]['categoryName'] == categoryName) {
        var lst = _localData[i]['categoryItems'] as List;
        for (var j = 0; j < lst.length; j++) {
          if (lst[i].itemId == itemId) {
            lst[i] = Item(
              categoryName: lst[i].categoryName,
              customizables: lst[i].customizables,
              description: lst[i].description,
              imageURL: lst[i].imageURL,
              isVeg: lst[i].isVeg,
              itemId: lst[i].itemId,
              itemName: lst[i].itemName,
              price: newPrice,
            );
            break;
          }
        }
      }
    }
    notifyListeners();
    return Future.value(true);
  }

  void deleteItem(String categoryName, UniqueKey itemId) {
    for (int i = 0; i < _localData.length; i++) {
      if (_localData[i]['categoryName'] == categoryName) {
        if ((_localData[i]['categoryItems'] as List).length == 1) {
          _localData.removeAt(i);
        } else {
          (_localData[i]['categoryItems'] as List)
              .removeWhere((element) => element.itemId == itemId);
        }
      }
    }

    notifyListeners();
  }
}
