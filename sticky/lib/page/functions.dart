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
