import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:juice/juice.dart';
import 'package:sticky/application.route.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/data/user.dart';

class Waterfall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userInfo = UserInfo.of(context);
    final user = userInfo.user;
    final avatar = tryRun(
      kAvatar,
      () => user.photoUrl,
      test: (String e) => e.isNotEmpty,
    );
    count++;
    return StreamBuilder<QuerySnapshot>(
      stream: userInfo.data.collection("days").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 120,
              snap: true,
              floating: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 16),
                title: Text(
                  'Every day of yours $count',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(avatar),
                    radius: 16,
                  ),
                  onPressed: () => openProfile(context),
                )
              ],
            ),
            if (snapshot.hasData && !snapshot.hasError && snapshot.data != null)
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      buildItem(context, index, snapshot.data.documents),
                ),
              ),
          ],
        );
      },
    );
  }

  void openProfile(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_PROFILE_PAGE);
  }

  Widget buildItem(
    BuildContext context,
    int index,
    List<DocumentSnapshot> documents,
  ) {
    if (index >= documents.length) return null;
    final doc = documents[index];
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            doc["create_time"],
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      ),
    );
  }
}
