import 'package:dio/dio.dart';
import 'package:peanut/network/error_interceptor.dart';

class DioClient {
  static Dio dio = Dio();

  static void setupDio() {
    dio.interceptors.add(ErrorInterceptor());
  }
}
