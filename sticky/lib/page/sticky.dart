import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/data/text_format.dart';
import 'package:sticky/data/user.dart';
import 'package:sticky/resource.dart';
import 'package:zefyr/zefyr.dart';

@RoutePage(params: [RouteParameter("sticky")])
class StickyPage extends StatefulWidget {
  const StickyPage({Key key, this.sticky}) : super(key: key);

  @override
  _StickyPageState createState() => _StickyPageState();

  final String sticky;
}

class _StickyPageState extends State<StickyPage> {
  final editer = TextEditingController(text: kSimpleText);

  static const kMoreSettingHideTop = -(32.0 + 64 * 2 + 54 * 2);

  double moreSettingTop = kMoreSettingHideTop;

  Color stickColor = kStickyColors[3];

  // String get title => editer.text.substring(0, editer.text.indexOf("\n"));
  String get title => kDateFormat.format(DateTime.now());

  ZefyrController text;
  NotusDocument document;
  ScrollController scrollController;
  double titleStartOffset = 16;
  final focus = FocusNode();

  DocumentSnapshot snapshot;
  StreamSubscription subscription;

  @override
  void initState() {
    rootBundle.loadString(Resources.doc).then((value) => setState(() {
          document = NotusDocument.fromJson(jsonDecode(value) as List);
          text = ZefyrController(document);
        }));
    document = NotusDocument();
    text = ZefyrController(document);
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          titleStartOffset = min(52, 16 + scrollController.offset / 5);
        });
      });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    subscription?.cancel();
    subscription = stickyReference
        .snapshots()
        .listen((data) => setState(() => snapshot = data));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController.dispose();
    subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: Theme.of(context).iconTheme,
                brightness: Theme.of(context).brightness,
                expandedHeight: 224,
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsetsDirectional.only(
                    start: titleStartOffset,
                    bottom: 16,
                  ),
                  title: Text(
                    title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  background: snapshot?.data != null
                      ? Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                snapshot.data["preview"],
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.2),
                                BlendMode.lighten,
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: openMoreSetting,
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 1200,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ZefyrScaffold(
                    child: ZefyrView(
                      document: document,
                      // controller: text,
                      // focusNode: focus,
                      imageDelegate: CustomImageDelegate(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Row(
          //     children: <Widget>[
          //       for (final format in kTextFormats)
          //         IconButton(
          //           icon: Icon(format.icon),
          //           onPressed: () => updateFormat(format),
          //         ),
          //     ],
          //   ),
          // ),
          // AnimatedContainer(
          //   child: buildMoreSetting(context),
          //   duration: kAnimeDurationFast,
          //   transform: Matrix4.identity()..translate(0.0, moreSettingTop),
          // ),
        ],
      ),
    );
  }

  Widget buildMoreSetting(BuildContext context) {
    return Material(
      elevation: 16,
      color: Theme.of(context).backgroundColor,
      child: Container(
        color: Colors.black.withOpacity(0.01),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        constraints: BoxConstraints.tightFor(width: double.infinity),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Wrap(
              children: <Widget>[
                for (final color in kStickyColors)
                  GestureDetector(
                    child: Container(
                      height: 64,
                      width: MediaQuery.of(context).size.width / 4,
                      color: color,
                    ),
                    onTap: () => setState(() {
                      stickColor = color;
                    }),
                  ),
              ],
            ),
            ListTileTheme(
              iconColor: Theme.of(context).errorColor,
              textColor: Theme.of(context).errorColor,
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text("删除笔记"),
                onTap: deleteSticky,
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: closeMoreSetting,
            ),
          ],
        ),
      ),
    );
  }

  void openMoreSetting() => setState(() => moreSettingTop = 0);

  void closeMoreSetting() =>
      setState(() => moreSettingTop = kMoreSettingHideTop);

  void updateFormat(TextFormat format) {}

  void deleteSticky() {}

  DocumentReference get stickyReference {
    final data = UserInfo.of(context, listen: false).data;
    return data.collection("stickies").document(widget.sticky);
  }
}

/// Custom image delegate used by this example to load image from application
/// assets.
///
/// Default image delegate only supports [FileImage]s.
class CustomImageDelegate extends ZefyrDefaultImageDelegate {
  @override
  Widget buildImage(BuildContext context, String imageSource) {
    // We use custom "asset" scheme to distinguish asset images from other files.
    if (imageSource.startsWith('asset://')) {
      final asset = new AssetImage(imageSource.replaceFirst('asset://', ''));
      return new Image(image: asset);
    } else {
      return super.buildImage(context, imageSource);
    }
  }
}
