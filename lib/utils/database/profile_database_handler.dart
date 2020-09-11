import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/auth/auth_handler.dart';
import '../../models/seller_profile.dart';

class DataBaseHandler {
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
          _firestore.collection('sellersAuth').doc(profile.phoneNumber),
          {'name': profile.name, 'DOC': DateTime.now()});
    });
    _firestore.runTransaction((transaction) async {
      transaction.set(_firestore.collection('sellers').doc(profile.phoneNumber),
          profile.toJson());
    });
  }

  Future<SellerProfile> fetchProfile() async {
    try {
      String phoneNumber = authHandler.getCurrentUser().phoneNumber;
      phoneNumber = phoneNumber.substring(3);
      print(phoneNumber);
      DocumentSnapshot snapshot =
          await _firestore.collection('sellers').doc(phoneNumber).get();
      SellerProfile profile = SellerProfile.fromMap(snapshot.data());
      return profile;
    } on PlatformException catch (e) {
      print('${e.code} ${e.message}');
      return null;
    }
  }
}

final DataBaseHandler dataBaseHandler = DataBaseHandler();
