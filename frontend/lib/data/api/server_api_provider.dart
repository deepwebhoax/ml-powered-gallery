import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';

class ServerApiProvider {
  ServerApiProvider._() {
    _dio = Dio(BaseOptions(baseUrl: "https://d1bb2b7e5823.ngrok.io"));
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

  // TODO: Use this method to classify !
  Future classifyImage(File file) async {
    FormData formdata = FormData.fromMap({
      "image": MultipartFile.fromFileSync(file.path),
    });

    Response response = await _dio.post("/predict",
        data: formdata,
        options: Options(headers: {
          "content-type": "multipart/form-data",
          Headers.contentLengthHeader: await file.length()
        }));

    if (response.statusCode != 200) {
      debugPrint('Error on image prediction');
      return;
    }
    return response.data; // {"class": "nature", "probability": 0.83}
  }
}
