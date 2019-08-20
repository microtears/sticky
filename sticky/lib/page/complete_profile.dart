import 'package:firebase_auth/firebase_auth.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:sticky/application.route.dart';
import 'package:sticky/data/user.dart';

@RoutePage()
class CompleteProfilePage extends StatefulWidget {
  @override
  _CompleteProfilePageState createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Theme.of(context).accentColor,
          ),
          onPressed: backHome,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Complete Profile",
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              "Register via your company email to connect with the people of your company.",
              style: Theme.of(context).textTheme.subhead,
            ),
            SizedBox(height: 24),
            Row(
              children: <Widget>[
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.25),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Center(
                          child: IconButton(
                            color: Theme.of(context).accentColor,
                            icon: Icon(Icons.photo_camera),
                            onPressed: chosePicture,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 24),
                Center(
                  child: Text(
                    "Add Profile Picture",
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 24),
            Container(
              height: 48,
              child: TextField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            SizedBox(height: 24),
            Container(
              constraints: BoxConstraints.expand(height: 48),
              child: RaisedButton(
                child: Text("Finish"),
                elevation: 0,
                onPressed: () => finish(context),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void chosePicture() {}

  void updateName() {
    final userUpdateInfo = prefix0.UserUpdateInfo()..displayName = _name.text;
    UserInfo.of(context, listen: false).user.updateProfile(userUpdateInfo);
  }

  void finish(BuildContext context) {
    updateName();
  }

  void backHome() {
    Navigator.of(context)
      ..pop()
      ..pushReplacementNamed(ROUTE_HOME);
  }
}
