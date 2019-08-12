import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:juice/juice.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/data/user.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserInfo.of(context).user;
    final avatar = tryRun(
      kAvatar,
      () => user.photoUrl,
      test: (String e) => e.isNotEmpty,
    );
    final name = tryRun(
      "未设置",
      () => user.displayName,
      test: (String e) => e.isNotEmpty,
    );
    final numStyle = Theme.of(context).textTheme.subhead.copyWith();
    final textStyle = Theme.of(context).textTheme.body1.copyWith(
          color: Theme.of(context).textTheme.body1.color.withOpacity(0.6),
        );
    final nameStyle = Theme.of(context).textTheme.title.copyWith(fontSize: 24);
    final top = 0.0 +
        72 * 2 +
        16 * 2 +
        MediaQuery.of(context).padding.top +
        nameStyle.fontSize;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: openSettings,
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 16),
                Center(
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(avatar),
                    radius: 64,
                  ),
                ),
                SizedBox(height: 16),
                Text(name, style: nameStyle),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: top),
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("0", style: numStyle),
                            Text("笔记", style: textStyle),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text("0", style: numStyle),
                            Text("关注者", style: textStyle),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text("0", style: numStyle),
                            Text("正在关注", style: textStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height - top / 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void openSettings() {}
}
