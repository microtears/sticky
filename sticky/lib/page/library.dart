import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:juice/juice.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/data/user.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
//                padding: EdgeInsets.only(top: 48),
//                color: Colors.green,
                child: Column(
                  children: <Widget>[
//                    SizedBox(height: 16),
                    Spacer(),
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
            buildAll(),
            buildPhotos(),
            buildMusic(),
          ],
        ),
      ),
    );
  }

  Widget buildMusic() => buildEmpty();

  Widget buildEmpty() => Column(
        children: <Widget>[
          Spacer(),
          Center(child: Text("Empty content")),
          Spacer(),
        ],
      );

  GridView buildPhotos() {
    return GridView.count(
      padding: EdgeInsets.zero,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: <Widget>[
        for (var i = 0; i < 30; i++)
          CachedNetworkImage(
            imageUrl: "https://source.unsplash.com/random/320x320?index=$i",
          ),
      ],
    );
  }

  Widget buildAll() => buildEmpty();
}
