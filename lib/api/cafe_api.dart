// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:admin_dashboard/api/config.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:dio/dio.dart';

class CafeApi {
  static final Dio _dio = Dio();

  static void configureDio() {
    //Base del url
    _dio.options.baseUrl = '${AppConfig.urlServer}/api';

    //Configurar Headers
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };
  }

//
  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);

      return resp.data;
    } on DioException catch (e) {
      print(e.response);
      throw ('Error en el GET');
    }
  }

  static Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.post(path, data: formData);
      return resp.data;
    } on DioException catch (e) {
      print(e);
      throw ('Error en el POST');
    }
  }

  static Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.put(path, data: formData);
      return resp.data;
    } on DioException catch (e) {
      print(e);
      throw ('Error en el PUT $e');
    }
  }

  static Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.delete(path, data: formData);
      return resp.data;
    } on DioException catch (e) {
      print(e);
      throw ('Error en el delete');
    }
  }

  static Future uploadFile(String path, Uint8List bytes) async {
    final formData =
        FormData.fromMap({'archivo': MultipartFile.fromBytes(bytes)});

    try {
      final resp = await _dio.put(path, data: formData);
      return resp.data;
    } on DioException catch (e) {
      print(e);
      throw ('Error en el PUT $e');
    }
  }
}
