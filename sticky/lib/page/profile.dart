import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:juice/juice.dart';
import 'package:sticky/application.route.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/data/user.dart';

//@RoutePage()
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
//    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserInfo.of(context, listen: false).user;
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
//    final numStyle = Theme.of(context).textTheme.subhead.copyWith();
//    final textStyle = Theme.of(context).textTheme.body1.copyWith(
//          color: Theme.of(context).textTheme.body1.color.withOpacity(0.6),
//        );
    final nameStyle = Theme.of(context).textTheme.title.copyWith(fontSize: 24);
    final top = 0.0 +
        62 * 2 +
        16 * 2 +
        MediaQuery.of(context).padding.top +
        nameStyle.fontSize;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            <Widget>[
          SliverAppBar(
            // pinned: true,
            expandedHeight: top,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                padding: EdgeInsets.only(top: 48),
                child: Column(
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
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => openSettings(context),
              )
            ],
          ),
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 0,
            backgroundColor: Theme.of(context).backgroundColor,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).textTheme.body1.color,
                tabs: <Widget>[
                  Tab(text: "All"),
                  Tab(text: "Photos"),
                  Tab(text: "Music"),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Center(child: Text("Empty content")),
            GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 3,
              childAspectRatio: 1,
              children: <Widget>[
                for (var i = 0; i < 30; i++)
                  CachedNetworkImage(
                    imageUrl:
                        "https://source.unsplash.com/random/320x320?index=$i",
                  ),
              ],
            ),
            Center(child: Text("Empty content")),
          ],
        ),
      ),
    );
  }

  void openSettings(BuildContext context) =>
      Navigator.pushNamed(context, ROUTE_SETTING_PAGE);
}
