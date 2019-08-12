// Copyright 2018 DebuggerX <dx8917312@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Modified by microtears  <microtears@gmail.com> with July 23, 2019.
// Adding features : excludes folders that need to be ignored.
// Add DO NOT MODIFY BY HAND.
// Add fonts class.
// Changed variable names.

import 'dart:io';

import 'package:path/path.dart';

const previewServerPort = 2227;

const ignores = [
  "dark",
  "2.0",
  "3.0",
];

class ClassType {
  ClassType(this.classname);

  String classname;
  Set<String> _lines = {};

  void addStaticField(
    String fieldType,
    String fieldName,
    String content, {
    bool isFinal = true,
    String comment = "",
  }) {
    _lines.add("\t\t$comment");
    final row = "\t\tstatic ${isFinal ? "final " : ""}"
        "$fieldType $fieldName = $content;\n";
    _lines.add(row);
  }

  @override
  String toString() {
    return 'class $classname {\n' + _lines.join("\n") + '}\n';
  }
}

String getHeader() {
  return '''
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AssetGenerator
// **************************************************************************

''';
}

bool isDirectory(String path) => FileSystemEntity.isDirectorySync(path);
bool isFile(String path) => FileSystemEntity.isFileSync(path);

void progressFile(ClassType classType, FileSystemEntity file) {
  if (isFile(file.path)) {
    print(file.path);
    final path = file.path.replaceAll('\\', '/');
    // var varName = withoutExtension(path).replaceAll('/', '_').replaceAll('.', '_').toLowerCase();
    var varName = basename(withoutExtension(path)).toLowerCase();
    var pos = 0;
    String char;
    while (true) {
      pos = varName.indexOf('_', pos);
      if (pos == -1) break;
      char = varName.substring(pos + 1, pos + 2);
      varName = varName.replaceFirst('_$char', '_${char.toUpperCase()}');
      pos++;
    }
    varName = varName.replaceAll('_', '');
    final comment = "/// ![](http://127.0.0.1:$previewServerPort/$path)";
    classType.addStaticField("String", varName, "'$path'", comment: comment);
  }
}

enum AssetsType {
  file,
  font,
  // todo Just for previewing images
  // todo Identify the image formats supported by flutter
  images,
  none,
}

void main(bool enableServer) async {
  bool workingLine = false;
  var pubspec = File('pubspec.yaml').readAsLinesSync();
  final resourceClass = ClassType("Resources");
  final fontsClass = ClassType("Fonts");
  AssetsType assetType = AssetsType.none;
  for (String line in pubspec) {
    if (line.contains('# assets begin')) {
      workingLine = true;
      assetType = AssetsType.file;
      continue;
    } else if (line.contains('# fonts begin')) {
      workingLine = true;
      assetType = AssetsType.font;
      continue;
    }
    if ((line.contains('assets') || line.contains('fonts')) &&
        line.contains('end') &&
        line.contains('#')) {
      workingLine = false;
      assetType = AssetsType.none;
    }
    if (workingLine && !line.contains('#')) {
      switch (assetType) {
        case AssetsType.file:
          final path = line
              .replaceAll('#', '')
              .replaceAll('*', '')
              .replaceAll('-', '')
              .trim();
          final isDirctory = isDirectory(path);
          if (isDirctory) {
            final folder = Directory(path);
            if (folder.existsSync()) {
              folder.listSync(recursive: true).where((FileSystemEntity item) {
                if (isFile(item.path)) return true;
                final name = basename(item.path);
                return !ignores.contains(name);
              }).forEach((item) => progressFile(resourceClass, item));
            }
          } else {
            progressFile(resourceClass, File(path));
          }
          break;
        case AssetsType.font:
          if (line.contains('- family:')) {
            final fontFamily = line.trim().substring(10);
            print(fontFamily);
            var fontFamilyName = fontFamily
                .toLowerCase()
                .replaceAll(' ', '_')
                .replaceAll('-', '_');
            var pos = 0;
            String char;
            while (true) {
              pos = fontFamilyName.indexOf('_', pos);
              if (pos == -1) break;
              char = fontFamilyName.substring(pos + 1, pos + 2);
              fontFamilyName = fontFamilyName.replaceFirst(
                  '_$char', '_${char.toUpperCase()}');
              pos++;
            }
            fontFamilyName = fontFamilyName.replaceAll('_', '');
            fontsClass.addStaticField(
                "String", fontFamilyName, "'$fontFamily'");
          }
          break;
        default:
      }
    }
  }

  final resourceFile = File('lib/resource.dart');
  if (resourceFile.existsSync()) resourceFile.deleteSync();
  resourceFile.createSync();
  resourceFile.writeAsStringSync(
      getHeader() + resourceClass.toString() + "\n\n" + fontsClass.toString());

  if (enableServer) {
    HttpServer server;
    try {
      server = await HttpServer.bind('127.0.0.1', previewServerPort);
      print('成功启动图片预览服务器于本机<$previewServerPort>端口');
      server.listen(
        (req) {
          var index = req.uri.path.lastIndexOf('.');
          var subType = req.uri.path.substring(index);
          req.response
            ..headers.contentType = ContentType('image', subType)
            ..add(File('.${req.uri.path}').readAsBytesSync())
            ..close();
        },
      );
    } catch (e) {
      print('图片预览服务器已启动或端口被占用');
    }
  }
}
