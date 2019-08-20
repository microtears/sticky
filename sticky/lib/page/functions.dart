import 'package:flutter/material.dart';
import 'package:sticky/application.route.dart';
import 'package:sticky/data/kvalue.dart';

void newSticky(BuildContext context) =>
    Navigator.pushNamed(context, ROUTE_STICKY_PAGE, arguments: null);

void signOut(BuildContext context) {
  kAuth.signOut();
  Navigator.popUntil(context, (route) {
    return route.isFirst;
  });
}

bool checkPasswordComplexity(String password, String password2) {
  if (password.length < 6) {
    throw Exception(kPasswordLengthErrorMessage);
  }
  if (RegExp(r"\s+").hasMatch(password)) {
    throw Exception(kPasswordSpacesErrorMessage);
  }
  if (password != password2) {
    throw Exception(kPasswordConfirmErrorMessage);
  }
  return true;
}
