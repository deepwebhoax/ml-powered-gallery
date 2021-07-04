import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';

class ServerApiProvider {
  ServerApiProvider._() {
    _dio = Dio();
  }

  static final ServerApiProvider instance = ServerApiProvider._();

  late Dio _dio;

  Future<bool> pushImage(Image image) async {
    try {
      return true;
    } on Exception catch (e) {
      debugPrint('error on pushImage - $e');
    }
    return false;
  }

  Future<Map<String, dynamic>> getImageStatus(int id) async {
    try {
      return {'request_status': 200, 'image_status': 'ready', 'id': id};
    } on Exception catch (e) {
      debugPrint('error on getImageStatus - $e');
    }
    return {'request_status': 500, 'image_status': 'no_data', 'id': id};
  }
}
