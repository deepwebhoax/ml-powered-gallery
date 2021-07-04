import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class DbProvider {
  DbProvider._();

  static final DbProvider instance = DbProvider._();

  List<Image> getAllImagesInFolderURL(String url) {
    try {
      final dir = Directory(url);
      final List<FileSystemEntity> contents = dir.listSync();
      return contents.map((file) => file.path).toList().map((imagePath) => Image.file(File(imagePath))).toList();
    } on Exception catch (e) {
      debugPrint('error on getAllImagesInFolderURL - $e');
    }
    return [];
  }
}
