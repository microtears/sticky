import 'package:flutter/material.dart';

@immutable
class TextFormat {
  final String name;
  final IconData icon;

  const TextFormat(this.name, this.icon);

  static const bold = TextFormat("bold", Icons.format_bold);
  static const italic = TextFormat("italic", Icons.format_italic);
  static const underlined = TextFormat("underlined", Icons.format_underlined);
  static const strikethrough =
      TextFormat("strikethrough", Icons.format_strikethrough);
  static const list_bulleted =
      TextFormat("list_bulleted", Icons.format_list_bulleted);
  static const image = TextFormat("image", Icons.image);

  static const values = [
    bold,
    italic,
    underlined,
    strikethrough,
    list_bulleted,
    image,
  ];
}
