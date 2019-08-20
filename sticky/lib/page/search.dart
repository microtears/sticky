import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shine/shine.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/tags.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 48),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: ShapeDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.1),
              shape: StadiumBorder(),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Type a word",
              ),
            ),
          ),
          SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: TagsView(
              tags: kTags,
              randomColor: true,
            ),
          ),
        ],
      ),
    );
  }
}
