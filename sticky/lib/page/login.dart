import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:sticky/application.route.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/data/user.dart' as u;
import 'package:sticky/snackbar.dart';
import 'package:sticky/sticky_logo.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  // final _password2 = TextEditingController();
  final _logo = StickyLogoController();
  var buildContext;

  bool get isLoading => _logo.isLoading;

  set isLoading(bool isLoading) {
    _logo.isLoading = isLoading;
  }

  @override
  void dispose() {
    _logo.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 32, end: 32),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Text(
                  "Sign In Now",
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  "Sign in with your account, enter your email and password to get started.",
                  style: Theme.of(context).textTheme.subhead,
                ),
                SizedBox(height: 24),
                Container(
                  height: 48,
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  height: 48,
                  child: TextField(
                    obscureText: true,
                    controller: _password,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  constraints: BoxConstraints.expand(height: 48),
                  child: RaisedButton(
                    child: Text(isLoading ? "Wating" : "Next"),
                    elevation: 0,
                    disabledColor:
                        Theme.of(context).textTheme.button.backgroundColor,
                    disabledTextColor: Theme.of(context).textTheme.button.color,
                    onPressed: isLoading ? null : handleSingIn,
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: Text(
                    "Forget password?",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                Center(
                  child: FlatButton(
                    child: Text("Reset"),
                    onPressed: () {},
                  ),
                ),
                Builder(
                  builder: (BuildContext context) {
                    buildContext = context;
                    return Container();
                  },
                )
              ],
            ),
            Positioned(
              top: 84,
              child: Hero(tag: kLogoTag, child: StickyLogo(controller: _logo)),
            )
          ],
        ),
      ),
    );
  }

  Future handleSingIn() async {
    if (isLoading) return;
    showLoading();
    final email = _email.text;
    final password = _password.text;

    final AuthCredential credential = EmailAuthProvider.getCredential(
      email: email,
      password: password,
    );
    log("email : " + email);
    log("pwd : " + password);
    try {
      final user = await kAuth.signInWithCredential(credential);
      log("signed in " + user.uid);
      closeLoading();
      backHome();
    } on PlatformException catch (e) {
      handleError(e.message, e);
    }
  }

  void showLoading() {
    isLoading = true;
  }

  void closeLoading() {
    isLoading = false;
  }

  void handleError(String message, [Object error]) {
    closeLoading();
    log(error?.toString());
    Scaffold.of(buildContext).showSnackBar(StickySnackBar(
      content: Text(message),
    ));
  }

  Future backHome() async {
    final user = await kAuth.currentUser();
    if (user != null) {
      u.UserInfo.of(context, listen: false).user = user;
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, ROUTE_HOME);
    }
  }
}
