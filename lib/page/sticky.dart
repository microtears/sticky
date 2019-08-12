import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/data/text_format.dart';

@RoutePage()
class StickyPage extends StatefulWidget {
  @override
  _StickyPageState createState() => _StickyPageState();
}

class _StickyPageState extends State<StickyPage> {
  final editer = TextEditingController(text: kSimpleText);

  static const kMoreSettingHideTop = -(32.0 + 64 * 2 + 54 * 2);

  double moreSettingTop = kMoreSettingHideTop;

  Color stickColor = kStickyColors[3];

  // String get title => editer.text.substring(0, editer.text.indexOf("\n"));
  String get title => kDateFormat.format(new DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: Theme.of(context).iconTheme,
                brightness: Theme.of(context).brightness,
                expandedHeight: 120,
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding:
                      EdgeInsetsDirectional.only(start: 16, bottom: 16),
                  title: Text(
                    title,
                    style: Theme.of(context).textTheme.title,
                  ),
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
                  color: stickColor,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
                        bottom: 4,
                      ),
                    ),
                    controller: editer,
                    maxLines: null,
                    minLines: 7,
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              children: <Widget>[
                for (final format in kTextFormats)
                  IconButton(
                    icon: Icon(format.icon),
                    onPressed: () => updateFormat(format),
                  ),
              ],
            ),
          ),
          AnimatedContainer(
            child: buildMoreSetting(context),
            duration: kAnimeDurationFast,
            transform: Matrix4.identity()..translate(0.0, moreSettingTop),
          ),
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
}
