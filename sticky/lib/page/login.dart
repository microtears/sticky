import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sticky/application.route.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/snackbar.dart';
import 'package:sticky/data/user.dart' as u;

@RoutePage()
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  var buildContext;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> loading;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "登录",
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                labelText: "邮箱",
              ),
              controller: _email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "密码",
              ),
              controller: _password,
            ),
          ),
          SizedBox(height: 64),
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("登录"),
                  SizedBox(width: 32),
                  Icon(Icons.arrow_forward),
                ],
              ),
              onPressed: handleSingIn,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              color: Colors.amberAccent,
            ),
          ),
          SizedBox(height: 64),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OutlineButton.icon(
                icon: Icon(FontAwesomeIcons.google, size: 14),
                label: Text("Google"),
                onPressed: googleSingIn,
                shape: StadiumBorder(),
                textColor: Colors.red,
                highlightedBorderColor: Colors.red,
                borderSide: BorderSide(color: Colors.red),
              ),
              OutlineButton.icon(
                icon: Icon(FontAwesomeIcons.twitter, size: 14),
                label: Text("Twitter"),
                onPressed: twitterSingIn,
                shape: StadiumBorder(),
                textColor: Colors.blue,
                highlightedBorderColor: Colors.blue,
                borderSide: BorderSide(color: Colors.blue),
              ),
            ],
          ),
          Spacer(flex: 1),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              buildContext = context;
              return Container();
            },
          ),
        ],
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
      handleError(e, e.message);
    }
  }

  Future googleSingIn() async {
    if (isLoading) return;
    showLoading();

    try {
      final GoogleSignInAccount googleUser = await kGoogleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final user = await kAuth.signInWithCredential(credential);
      log("signed in " + user.displayName);
      closeLoading();
      backHome();
    } on PlatformException catch (e) {
      handleError(e, e.message);
    } catch (e) {
      handleError(e, e.toString());
    }
  }

  void twitterSingIn() {
    if (isLoading) return;
    showLoading();
    closeLoading();
    Scaffold.of(buildContext).showSnackBar(StickySnackBar(
      content: Text("Not yet implement."),
    ));
  }

  void showLoading() {
    isLoading = true;
    loading = Scaffold.of(buildContext).showSnackBar(StickySnackBar(
      content: Row(
        children: <Widget>[
          Container(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(),
          ),
          Spacer(),
          Text("正在登录"),
          Spacer(),
        ],
      ),
      duration: kMaxDuration,
    ));
  }

  void closeLoading() {
    loading.close();
    isLoading = false;
  }

  void handleError(error, message) {
    closeLoading();
    log(error.toString());
    Scaffold.of(buildContext).showSnackBar(StickySnackBar(
      content: Text(message),
    ));
  }

  Future backHome() async {
    final user = await kAuth.currentUser();
    if (user != null) {
      u.UserInfo.of(context, listen: false).user = user;
      Navigator.pushReplacementNamed(context, ROUTE_HOME);
    }
  }
}
