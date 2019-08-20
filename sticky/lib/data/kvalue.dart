import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:shine/shine.dart';
import 'package:sticky/data/text_format.dart';
import 'package:sticky/tags.dart';

final kFireStore = Firestore.instance;
final kDocument = Firestore.instance.collection("common");
final kGoogleSignIn = GoogleSignIn();
final kAuth = FirebaseAuth.instance;
const kMaxDuration = Duration(days: 365);
const kAnimeDuration = Duration(milliseconds: 300);
const kAnimeDurationFast = Duration(milliseconds: 200);
final kDateFormat = DateFormat("yyyy-MM-dd");
final kDarkBlack = hexColor("#000");
const kAvatar =
    "https://img.tuzhaozhao.com/2018/05/02/6b96a9d3fa5d67aa_600x600.jpg";
var count = 0;

const kLogoTag = "sticky_logo_hero_tag";

const kTestBackground =
    "https://cdn.pixabay.com/photo/2019/08/04/20/05/blossom-4384646_960_720.jpg";

const kTextFormats = TextFormat.values;

const kStickyColors = [
  Color.fromARGB(255, 147, 208, 238),
  Color.fromARGB(255, 224, 224, 224),
  Color.fromARGB(255, 118, 118, 118),
  Color.fromARGB(255, 255, 255, 255),
  Color.fromARGB(255, 255, 230, 110),
  Color.fromARGB(255, 161, 239, 155),
  Color.fromARGB(255, 255, 175, 223),
  Color.fromARGB(255, 215, 175, 255),
];

const kSimpleText = """
电影少女

日剧版《电影少女》系列新作《电影少女 -VIDEO GIRL MAI 2019-》追加出演：武田玲奈、户次重幸。武田玲奈将出演女高中生兼模特朝川由那，户次重幸将继续饰演弄内洋太。该作将从4月11日起，每周四在东京电视台的“木ドラ25”播出，详见：https://www.tv-tokyo.co.jp/videogirl2019/

原作：桂正和
出演：山下美月（乃木坂46）、萩原利久、武田玲奈、戸次重幸
总监督：関和亮
监督：真壁幸紀、湯浅弘章、山岸聖太、川井隼人

""";

const kPasswordLengthErrorMessage =
    "Your password must be at least 5 characters long and cannot contain spaces.";
const kPasswordConfirmErrorMessage = "Your password can not contain spaces.";
const kPasswordSpacesErrorMessage = "The two passwords you typed do not match.";

const kTags = [
  Tag("Travel", icon: FontAwesomeIcons.route),
  Tag("Food & Drink", icon: FontAwesomeIcons.egg),
  Tag("Film", icon: FontAwesomeIcons.film),
  Tag("Bussiness & Work", icon: FontAwesomeIcons.globe),
  Tag("People", icon: FontAwesomeIcons.userFriends),
  Tag("Health", icon: FontAwesomeIcons.running),
  Tag("Password", icon: FontAwesomeIcons.key),
  Tag("Quick Tips", icon: FontAwesomeIcons.bullhorn),
  Tag("Code", icon: FontAwesomeIcons.terminal),
];
