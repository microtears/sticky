import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sticky/page/functions.dart';

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: IconButton(
          icon: Icon(
            FontAwesomeIcons.stickyNote,
            size: 120,
          ),
          onPressed: () => newSticky(context),
        ),
      ),
    );
  }
}
