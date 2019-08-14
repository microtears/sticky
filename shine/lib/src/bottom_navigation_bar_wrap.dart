import 'package:flutter/material.dart';

// TODO(microtears) write doc
class BottomNavigationBarWrap extends StatelessWidget {
  final BottomNavigationBar child;
  final ValueChanged<int> onLongPress;

  const BottomNavigationBarWrap({
    Key key,
    @required this.child,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        child,
        Positioned.fill(
          child: Row(
            children: <Widget>[
              for (var i = 0; i < child.items.length; i++)
                Expanded(
                  child: GestureDetector(
                    onLongPress:
                        onLongPress != null ? () => onLongPress(i) : null,
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
