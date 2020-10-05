import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/database/db_handler.dart';
import '../models/item_model.dart';

class MenuItemsProvider extends ChangeNotifier {
  DBHandler _menuHandler;
  Map<String, List<Item>> _fetchedData;

  Map<String, List<Item>> get menuItems => _fetchedData;

  void setMenuDBHandler(String phoneNumebr) async {
    if (_menuHandler == null) {
      _menuHandler = DBHandler('/sellers/$phoneNumebr/myMenu');
      // Fetching latest menu Items
      await fetchLatestMenuItems();
      notifyListeners();
    }
  }

  Future<void> fetchLatestMenuItems() async {
    QuerySnapshot snap = await _menuHandler.getDataCollection();
    List<Item> items = snap.docs.map((e) => Item.fromMap(e.data())).toList();
    Map<String, List<Item>> _tempData = {};
    items.forEach((element) {
      if (_tempData.containsKey(element.categoryName)) {
        _tempData[element.categoryName].add(element);
      } else {
        _tempData.putIfAbsent(element.categoryName, () => [element]);
      }
    });
    _fetchedData = _tempData;
  }

  Future<bool> addMenuItem(Item item) async {
    // Adding item to database
    // Uploading image is not implemented yet
    _menuHandler.addDocumentById(item.itemId, item.toJson());
    // Adding item to local data
    if (_fetchedData.containsKey(item.categoryName)) {
      _fetchedData[item.categoryName].add(item);
    } else {
      _fetchedData.putIfAbsent(item.categoryName, () => [item]);
    }
    notifyListeners();
    return true;
  }

  void deleteMenuItem(String itemId, String category) async {
    // Deleting data from Database
    await _menuHandler.removeDocument(itemId);
    // Here not refreshing data from the database as the item can be removed from the locally itself
    // So no requirement of the refreshment from database
    if (_fetchedData[category].length == 1) {
      _fetchedData.remove(category);
    } else {
      _fetchedData[category].removeWhere((element) => element.itemId == itemId);
    }
    notifyListeners();
  }
}
