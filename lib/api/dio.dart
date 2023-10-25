import 'package:dio/dio.dart';
import 'package:peanut/api/error_interceptor.dart';
import 'package:flutter/material.dart'; // Import Flutter's BuildContext

class DioClient {
  static Dio dio = Dio();

  static void setupDio() {
    dio.interceptors.add(ErrorInterceptor());
  }
}
