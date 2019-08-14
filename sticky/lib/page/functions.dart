import 'package:flutter/material.dart';
import 'package:sticky/application.route.dart';

void newSticky(BuildContext context) =>
    Navigator.pushNamed(context, ROUTE_STICKY_PAGE, arguments: null);
