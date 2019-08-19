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
import 'package:sticky/sticky_logo.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _password2 = TextEditingController();
  var buildContext;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> loading;
  bool isLoading = false;
  bool isSignUp = false;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Column(
  //       children: <Widget>[
  //         Spacer(flex: 1),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 16),
  //           child: Align(
  //             alignment: Alignment.centerLeft,
  //             child: Text(
  //               "Sticky",
  //               style: Theme.of(context).textTheme.display1,
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 32),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: TextField(
  //             decoration: InputDecoration(
  //               labelText: "邮箱",
  //             ),
  //             controller: _email,
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: TextField(
  //             obscureText: true,
  //             decoration: InputDecoration(
  //               labelText: "密码",
  //             ),
  //             controller: _password,
  //           ),
  //         ),
  //         if (isSignUp)
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 20),
  //             child: TextField(
  //               obscureText: true,
  //               decoration: InputDecoration(
  //                 labelText: "确认密码",
  //               ),
  //               controller: _password2,
  //             ),
  //           ),
  //         SizedBox(height: 64),
  //         Align(
  //           alignment: Alignment.centerRight,
  //           child: FlatButton(
  //             child: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 Text(isSignUp ? "注册" : "登录"),
  //                 SizedBox(width: 32),
  //                 Icon(Icons.arrow_forward),
  //               ],
  //             ),
  //             onPressed: isSignUp ? handleSingUp : handleSingIn,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(24),
  //                 bottomLeft: Radius.circular(24),
  //               ),
  //             ),
  //             color: Colors.amberAccent,
  //           ),
  //         ),
  //         SizedBox(height: 64),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: <Widget>[
  //             OutlineButton.icon(
  //               icon: Icon(FontAwesomeIcons.google, size: 14),
  //               label: Text("Google"),
  //               onPressed: googleSingIn,
  //               shape: StadiumBorder(),
  //               textColor: Colors.red,
  //               highlightedBorderColor: Colors.red,
  //               borderSide: BorderSide(color: Colors.red),
  //             ),
  //             OutlineButton.icon(
  //               icon: Icon(FontAwesomeIcons.twitter, size: 14),
  //               label: Text("Twitter"),
  //               onPressed: twitterSingIn,
  //               shape: StadiumBorder(),
  //               textColor: Colors.blue,
  //               highlightedBorderColor: Colors.blue,
  //               borderSide: BorderSide(color: Colors.blue),
  //             ),
  //           ],
  //         ),
  //         Spacer(flex: 1),
  //         LayoutBuilder(
  //           builder: (BuildContext context, BoxConstraints constraints) {
  //             buildContext = context;
  //             return Container();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 32, end: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 84),
            Hero(tag: kLogoTag, child: StickyLogo()),
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
                child: Text("Next"),
                elevation: 0,
                onPressed: () {},
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

  Future googleSingIn() async {
    if (isLoading) return;
    showLoading();
    final GoogleSignInAccount googleUser = await kGoogleSignIn.signIn();
    if (googleUser != null) {
      try {
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
        handleError(e.message, e);
      } catch (e) {
        handleError(e.toString(), e);
      }
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

  Future handleSingUp() async {
    if (isLoading) return;
    showLoading();
    final email = _email.text;
    final password = _password.text;
    final password2 = _password2.text;
    log("sign up:");
    log("email : " + email);
    log("pwd : " + password);
    log("pwd confirm : " + password2);
    try {
      checkPasswordComplexity(password, password2);
      final user = await kAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("signed up " + user.uid);
      closeLoading();
      backHome();
    } catch (e) {
      handleError(e.toString(), e);
    }
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
      Navigator.pushReplacementNamed(context, ROUTE_HOME);
    }
  }

  void checkPasswordComplexity(String password, String password2) {
    if (password != password2) {
      throw Exception("两次输入的密码不一致");
    }
  }
}
