import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:sticky/application.route.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/resource.dart';
import 'package:sticky/sticky_logo.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: <Widget>[
            Center(
              child: Hero(tag: kLogoTag, child: StickyLogo()),
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    textColor: Theme.of(context).disabledColor,
                    child: Text("Skip"),
                    onPressed: skip,
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 3,
                  child: SvgPicture.asset(Resources.welcomePageTwo),
                ),
                Spacer(),
                Text(
                  "Writing by Sticky",
                  style: Theme.of(context).textTheme.title,
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    textColor: Theme.of(context).accentColor,
                    child: Text("Next"),
                    onPressed: () => next(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void skip() {}

  void next(BuildContext context) {
    Navigator.pushReplacementNamed(context, ROUTE_START_PAGE);
  }
}
