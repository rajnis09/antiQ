import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/profile_models.dart';
import '../utils/database/profile_database_handler.dart';

class ProfileServiceProvider extends ChangeNotifier {
  SellerProfile _sellerProfile;
  static String defaultImageURL =
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
      user: User(
          name: name,
          email: email,
          imageURL: defaultImageURL,
          phoneNumber: phoneNumber),
      shop: Shop(
          name: shopName,
          imageURL: defaultImageURL,
          ownerName: shopOwnerName,
          phoneNumber: shopPhoneNumber,
          description: shopDescription,
          address: shopAddress),
    );
  }

  Future<void> fetchLatestProfile() async {
    DocumentSnapshot snap = await dataBaseHandler.fetchProfile();
    _sellerProfile = SellerProfile.fromMap(snap.data());
    print(_sellerProfile.user.name);
    notifyListeners();
  }

  Future<void> createSeller() async {
    await dataBaseHandler.createUserFirstTime(_sellerProfile);
    notifyListeners();
  }
}
