import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sticky/data/kvalue.dart';

class UserInfo with ChangeNotifier {
  FirebaseUser _user;

  FirebaseUser get user => _user;

  set user(FirebaseUser user) {
    assert(user != null);
    if (_user?.uid == user.uid) {
      return;
    }
    _user = user;
    _data = kFireStore.collection("users").document(user.uid.toString());
    notifyListeners();
  }

  DocumentReference _data;

  DocumentReference get data => _data;

  static UserInfo of(BuildContext context, {bool listen = false}) =>
      Provider.of<UserInfo>(context, listen: listen);
}
