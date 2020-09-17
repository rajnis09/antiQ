import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class Auth {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  firebase_auth.User _user;
  firebase_auth.FirebaseAuth get auth => _auth;

  firebase_auth.User getCurrentUser() {
    try {
      _user = _auth.currentUser;
    } catch (e) {
      _user = null;
      print('authHandler: error in currentUser $e');
    }
    return _user;
  }

  Future<void> userReload() async {
    try {
      _user = _auth.currentUser;
      await _user.reload();
      _user = _auth.currentUser;
    } catch (e) {
      print("authHandler: Error in userReload $e");
      _user = null;
    }
  }

  Future<int> phoneUserLoginOrRegister(
      firebase_auth.AuthCredential credential) async {
    int res = 0;
    firebase_auth.UserCredential authResult;
    try {
      authResult = await _auth.signInWithCredential(credential);
      _user = authResult.user;
      print("Signed IN");
      if (authResult.additionalUserInfo.isNewUser) {
        _user = _auth.currentUser;
        print('New User');
        res = 1;
      }
      print('In authahndler ${_user.phoneNumber}');
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('Error in authHanadler ${e.message}');
      switch (e.code) {
        case 'account-exists-with-different-credential':
          res = 2;
          break;
        case 'invalid-credential':
          res = 3;
          break;
        case 'user-disabled':
          res = 4;
          break;
        case 'operation-not-allowed':
          res = 5;
          break;
        case 'invalid-verification-code':
          res = 6;
          break;
        // invalid-verification-id or other type of errors
        default:
          res = 7;
          break;
      }
    }
    return res;
  }

  void signOut() async {
    if (_auth != null) await _auth.signOut();
  }

  Future<void> updateUserData(String name, String photoUrl) async {
    _user = _auth.currentUser;
  }
}

final Auth authHandler = Auth();
