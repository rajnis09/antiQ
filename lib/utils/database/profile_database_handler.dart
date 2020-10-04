import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/profile_models.dart';
import '../../utils/auth/auth_handler.dart';

class ProfileDataBaseHandler {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isAllowed(String phoneNumber) async {
    DocumentSnapshot id;
    id = await _firestore.collection('usersAuth').doc(phoneNumber).get();
    print(id.exists);
    if (id.exists) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> nextRoute(String phoneNumber) async {
    // 0-> register
    // 1-> login
    // 2-> don't login
    int nextState = 0;
    DocumentSnapshot id;
    id = await _firestore.collection('usersAuth').doc(phoneNumber).get();
    if (id.exists) {
      nextState = 2;
    } else {
      id = await _firestore.collection('sellersAuth').doc(phoneNumber).get();
      if (id.exists) {
        nextState = 1;
      }
    }
    return nextState;
  }

  Future<void> createUserFirstTime(SellerProfile profile) async {
    _firestore.runTransaction((transaction) async {
      transaction.set(
          _firestore.collection('sellers').doc(profile.shop.phoneNumber), {
        'profile': profile.toJson(),
        'menuItemsCounter': profile.menuItemsCounter
      });
    });
    _firestore.runTransaction((transaction) async {
      transaction.set(
          _firestore.collection('sellersAuth').doc(profile.shop.phoneNumber), {
        'name': profile.user.name,
        'shopName': profile.shop.name,
        'DOC': DateTime.now()
      });
    });
  }

  Future<DocumentSnapshot> fetchProfile() async {
    try {
      if (authHandler.getCurrentUser() != null) {
        String phoneNumber = authHandler.getCurrentUser().phoneNumber;
        phoneNumber = phoneNumber.substring(3);
        print(phoneNumber);
        return await _firestore.collection('sellers').doc(phoneNumber).get();
      }
    } on PlatformException catch (e) {
      print('${e.code} ${e.message}');
    }
    return null;
  }

  void updateData(SellerProfile profile) async {
    await _firestore
        .collection('sellers')
        .doc(profile.shop.phoneNumber)
        .update({
      'profile': profile.toJson(),
      'menuItemsCounter': profile.menuItemsCounter
    });
  }
}

final ProfileDataBaseHandler profileDataBaseHandler = ProfileDataBaseHandler();
