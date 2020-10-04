import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/profile_models.dart';
import '../utils/database/profile_database_handler.dart';

class ProfileServiceProvider extends ChangeNotifier {
  SellerProfile _sellerProfile;
  static String _defaultImageURL =
      "https://drive.google.com/uc?export=download&id=1hBu6cfZvlVFm3-AB8PBx2K4AZoiAXf4e";

  SellerProfile get profile => _sellerProfile;

  void createNewSellerObject(
      String name,
      String email,
      String phoneNumber,
      String shopName,
      String shopOwnerName,
      String shopPhoneNumber,
      String shopDescription,
      String shopAddress) {
    _sellerProfile = SellerProfile(
      menuItemsCounter: -1,
      user: User(
          name: name,
          email: email,
          imageURL: _defaultImageURL,
          phoneNumber: phoneNumber),
      shop: Shop(
          name: shopName,
          imageURL: _defaultImageURL,
          ownerName: shopOwnerName,
          phoneNumber: shopPhoneNumber,
          description: shopDescription,
          address: shopAddress),
    );
  }

  Future<void> fetchLatestProfile() async {
    DocumentSnapshot snap = await profileDataBaseHandler.fetchProfile();
    _sellerProfile = SellerProfile.fromMap(
        snap.data()['profile'], snap.data()['menuItemsCounter']);
    print('Logged in as ${_sellerProfile.user.name}');
    notifyListeners();
  }

  Future<void> createSeller() async {
    await profileDataBaseHandler.createUserFirstTime(_sellerProfile);
    notifyListeners();
  }

  void updateMenuCounter() {
    _sellerProfile = SellerProfile(
        menuItemsCounter: _sellerProfile.menuItemsCounter + 1,
        shop: _sellerProfile.shop,
        user: _sellerProfile.user);
    profileDataBaseHandler.updateData(_sellerProfile);
    // print('UpdateSuccess');
    notifyListeners();
  }
}
