// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/page/functions.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {});
  testWidgets("check subtype", (tester) async {
    final x = CustomScrollView();
    expect(x is ScrollView, true);
  });
  // testWidgets("Geting text must not empty", (tester) async {
  //   final text = await fetchHitokoto();
  //   print(text);
  //   expect(text.trim().isNotEmpty, true);
  // });

  testWidgets("password virify", (tester) async {
    expect(checkPasswordComplexity("password", "password"), true);
    expect(
      () => checkPasswordComplexity("password", "password2"),
      throwsA(allOf(
        isException,
        predicate((e) => e.message == kPasswordConfirmErrorMessage),
      )),
    );
    expect(
      () => checkPasswordComplexity("passw", "passw"),
      throwsA(allOf(
        isException,
        predicate((e) => e.message == kPasswordLengthErrorMessage),
      )),
    );
    expect(
      () => checkPasswordComplexity("passwor d", "passwor d"),
      throwsA(allOf(
        isException,
        predicate((e) => e.message == kPasswordSpacesErrorMessage),
      )),
    );
  });
}
