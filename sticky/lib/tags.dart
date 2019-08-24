import 'package:flutter/material.dart';
import 'package:sticky/util.dart' as util;

class TagsView extends StatefulWidget {
  final List<Tag> tags;
  final bool randomColor;
  final ValueChanged<int> onDelete;
  final bool enableDelete;
  const TagsView({
    Key key,
    this.tags,
    this.randomColor = false,
    this.onDelete,
    this.enableDelete = false,
  }) : super(key: key);

  @override
  _TagsViewState createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  List<_Tag> tags;

  @override
  void initState() {
    super.initState();
    tags = widget.tags
        .map((e) => _Tag(
              e,
              e.enableDelete != null ? e.enableDelete : widget.enableDelete,
              widget.randomColor ? util.randomColor() : null,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 16,
        children: <Widget>[
          for (var item in tags.asMap().entries)
            Chip(
              avatar: item.value.value.icon == null
                  ? null
                  : Container(
                      decoration: ShapeDecoration(
                        color: item.value.randomColor != null
                            ? item.value.randomColor.withOpacity(0.7)
                            : item.value.value.iconBackgroundColor,
                        shape: CircleBorder(),
                      ),
                      height: 24,
                      width: 24,
                      child: Container(
                        child: Icon(
                          item.value.value.icon,
                          size: 12,
                          color: Theme.of(context).textTheme.button.color,
                        ),
                      ),
                    ),
              label: Text(item.value.value.tag),
              backgroundColor: item.value.randomColor != null
                  ? Color.alphaBlend(
                      Colors.white.withOpacity(0.9), item.value.randomColor)
                  : item.value.value.color,
              deleteIcon: Icon(
                Icons.close,
                size: 24,
                color: Theme.of(context).primaryColorDark,
              ),
              onDeleted: item.value.enableDelete
                  ? () => widget?.onDelete(item.key)
                  : null,
            )
        ],
      ),
    );
  }
}

@immutable
class Tag {
  final String tag;
  final Color color;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final bool enableDelete;
  const Tag(
    this.tag, {
    this.color,
    this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.enableDelete,
  });
}

class _Tag {
  final Tag value;
  final bool enableDelete;
  final Color randomColor;

  _Tag(this.value, this.enableDelete, this.randomColor);
}
