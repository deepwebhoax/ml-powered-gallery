import 'package:bbbb_cv_app/domain/models/category.dart';

class Const {
  static const String defaultTitle = 'Photo Viewer';

  static const String linuxValidDirectoryUrl = r"documents_dataset";
  static const String windowsValidDirectoryUrl =
      r"G:\Projects\documents_dataset\documents_dataset";

  static const double switchGridPageSize = 900.0;

  static const List<Category> testCategories = [
    Category('cat'),
    Category('dog'),
    Category('nature'),
    Category('documents'),
    Category('food'),
  ];

  static const String apiUrl = 'https://d1bb2b7e5823.ngrok.io';
}
