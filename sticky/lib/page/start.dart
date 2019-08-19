import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:sticky/application.route.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/sticky_logo.dart';

@RoutePage()
class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 32, end: 32),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Get Started",
                      style: Theme.of(context).textTheme.display1,
                    ),
                    Text(
                      "Sign up for new account, enter your email and get started.",
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
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.5),
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
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.5),
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
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.5),
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
                        onPressed: () => next(context),
                      ),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: Text(
                        "Already have an account?",
                        style: Theme.of(context).textTheme.subhead,
                      ),
                    ),
                    Center(
                      child: FlatButton(
                        child: Text("Log In"),
                        onPressed: () => login(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 84,
              child: Hero(tag: kLogoTag, child: StickyLogo()),
            )
          ],
        ),
      ),
    );
  }

  // Future handleSingUp() async {
  //   if (isLoading) return;
  //   showLoading();
  //   final email = _email.text;
  //   final password = _password.text;
  //   final password2 = _password2.text;
  //   log("sign up:");
  //   log("email : " + email);
  //   log("pwd : " + password);
  //   log("pwd confirm : " + password2);
  //   try {
  //     checkPasswordComplexity(password, password2);
  //     final user = await kAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     log("signed up " + user.uid);
  //     closeLoading();
  //     backHome();
  //   } catch (e) {
  //     handleError(e.toString(), e);
  //   }
  // }

  next(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_COMPLETE_PROFILE_PAGE);
  }

  login(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_LOGIN_PAGE);
  }
}
