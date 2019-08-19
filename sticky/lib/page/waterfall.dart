import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/rendering.dart';
import 'package:juice/juice.dart';
import 'package:shine/shine.dart' as shine;
import 'package:sticky/application.route.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/data/user.dart';
import 'package:sticky/util.dart';

class Waterfall extends StatefulWidget {
  final VoidCallback onSearchButton;

  const Waterfall({Key key, this.onSearchButton}) : super(key: key);

  @override
  _WaterfallState createState() => _WaterfallState();
}

class _WaterfallState extends State<Waterfall> {
  final ScrollController _controller = ScrollController();
  UserInfo userInfo;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userInfo = UserInfo.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final userInfo = UserInfo.of(context);
    final user = userInfo.user;
    final avatar = tryRun(
      kAvatar,
      () => user.photoUrl,
      test: (String e) => e.isNotEmpty,
    );
    count++;
    final iconSize = 48.0;
    final avatarRotateAngle = tryRun(
        0.0, () => _controller.offset / MediaQuery.of(context).size.height);
    return StreamBuilder<QuerySnapshot>(
      stream: userInfo.data.collection("days").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 140,
              backgroundColor: Theme.of(context).backgroundColor,
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 16),
                title: Text(
                  'Record your moment',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              actions: <Widget>[
                Transform.rotate(
                  angle: avatarRotateAngle,
                  child: IconButton(
                    icon: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(avatar),
                      radius: 16,
                    ),
                    onPressed: () => openProfile(context),
                  ),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Material(
                          elevation: 8,
                          shape: CircleBorder(),
                          child: Container(
                            height: iconSize,
                            width: iconSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).accentColor,
                            ),
                            child: Center(
                              child: IconButton(
                                color: Theme.of(context).textTheme.button.color,
                                icon: Icon(Icons.add),
                                padding: EdgeInsets.zero,
                                onPressed: () => openSticky(context, null),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Add new",
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(fontSize: 11),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                    SizedBox(width: 16),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Material(
                          elevation: 8,
                          shape: CircleBorder(),
                          child: Container(
                            height: iconSize,
                            width: iconSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: shine.hexColor("#7540EE"),
                            ),
                            child: Center(
                              child: IconButton(
                                color: Theme.of(context).textTheme.button.color,
                                icon: Icon(Icons.search),
                                padding: EdgeInsets.zero,
                                onPressed: widget.onSearchButton,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Search",
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(fontSize: 11),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (handleStreamError(snapshot) &&
                snapshot.data.documents.isNotEmpty)
              // SliverFixedExtentList(
              SliverList(
                // itemExtent: 300,
                delegate: SliverChildBuilderDelegate(
                  (context, index) => buildDaysItem(
                    context,
                    index,
                    snapshot.data.documents,
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Container(
                height: 240,
                child: Center(
                  child: Text(
                    "No more content.",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void openProfile(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_PROFILE_PAGE);
  }

  Widget buildDaysItem(
    BuildContext context,
    int index,
    List<DocumentSnapshot> documents,
  ) {
    if (index >= documents.length) return null;
    final doc = documents[index];
    final headStyle = Theme.of(context).textTheme.title;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            // documentID is date
            doc.documentID,
            style: headStyle,
          ),
        ),
        StreamBuilder(
          stream: doc.reference.collection("stickies").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (handleStreamError(snapshot)) {
              final stickyContainerHeight = 225.0;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: stickyContainerHeight,
                // color: Colors.greenAccent,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 1.8 / 1,
                    // single line
                    maxCrossAxisExtent: stickyContainerHeight,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                  ),
                  itemCount: snapshot.data.documents.length * 30,
                  itemBuilder: (context, index) => GestureDetector(
                    child: buildStickiesItem(
                      context,
                      index,
                      snapshot.data.documents,
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text(snapshot.error.toString()),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget buildStickiesItem(
    BuildContext context,
    int index,
    List<DocumentSnapshot> documents,
  ) {
    // TODO(microtears) restore when release
    // final doc = documents[index];
    final doc = documents[index % documents.length];
    final sticky = doc["ref"] as DocumentReference;

    final titleStyle = Theme.of(context).textTheme.body1.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w800,
        );
    final shortStyle = Theme.of(context).textTheme.body1.copyWith(
          color: Theme.of(context).textTheme.body1.color.withOpacity(0.7),
          fontWeight: FontWeight.w200,
          fontSize: 13,
        );
    return StreamBuilder(
      stream: sticky.snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (handleStreamError(snapshot)) {
          final data = snapshot.requireData;
          final preview = data["preview"] ?? kAvatar;
          final title = data["title"] ?? "无标题";
          final short = data["short"] ?? "";
          return GestureDetector(
            onTap: () => openSticky(context, doc.documentID),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 16),
                AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: preview,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Center(
                      child: Container(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: Container(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
                Text("$title", style: titleStyle),
                Text(
                  "$short",
                  style: shortStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16),
              ],
            ),
          );
        } else {
          return Center(
            child: Container(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  void openSticky(BuildContext context, String documentID) {
    Navigator.pushNamed(context, ROUTE_STICKY_PAGE, arguments: documentID);
  }
}
