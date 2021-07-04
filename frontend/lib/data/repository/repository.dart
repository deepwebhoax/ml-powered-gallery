import 'package:bbbb_cv_app/data/api/server_api_provider.dart';
import 'package:bbbb_cv_app/data/db/db_provider.dart';
import 'package:flutter/widgets.dart';

class Repository {
  Repository._() {
    _dbProvider = DbProvider.instance;
    _serverApiProvider = ServerApiProvider.instance;
  }

  static final Repository instance = Repository._();

  late DbProvider _dbProvider;
  late ServerApiProvider _serverApiProvider;

  Future<bool> pushImageToServer(Image image) async {
    return await _serverApiProvider.pushImage(image);
  }

  Future<Map<String, dynamic>> getImageStatusFromServer(int id) async {
    return await _serverApiProvider.getImageStatus(id);
  }

  List<Image> getAllImagesInFolderURL(String url) {
    return _dbProvider.getAllImagesInFolderURL(url);
  }
}
