import 'dart:async';

import 'package:flutter/foundation.dart';

import '../utils/database/profile_database_handler.dart';

import '../models/seller_profile.dart';

class ProfileProvider extends ChangeNotifier {
  SellerProfile _sellerProfile;

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
        name,
        email,
        "https://drive.google.com/uc?export=download&id=1hBu6cfZvlVFm3-AB8PBx2K4AZoiAXf4e",
        phoneNumber,
        shopName,
        shopOwnerName,
        shopPhoneNumber,
        shopDescription,
        shopAddress);
  }

  Future<void> createSeller() async {
    await dataBaseHandler.createUserFirstTime(_sellerProfile);
    notifyListeners();
  }

  Future<void> fetchSellerProfile() async {
    _sellerProfile = await dataBaseHandler.fetchProfile();
    print('${_sellerProfile.name} ${_sellerProfile.phoneNumber}');
    notifyListeners();
  }

  void removeLocalSessionSellerProfile() {
    _sellerProfile = null;
  }
}
