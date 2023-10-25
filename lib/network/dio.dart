import 'package:dio/dio.dart';
import 'package:peanut/network/error_interceptor.dart'; // Import Flutter's BuildContext

class DioClient {
  static Dio dio = Dio();

  static void setupDio() {
    dio.interceptors.add(ErrorInterceptor());
  }
}
