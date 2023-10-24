import 'package:get/get.dart';
import 'package:peanut/api/dio.dart';
import 'package:peanut/api/api_config.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String login, String password) async {
    try {
      final response = await DioClient.dio.post(
        '${ApiConfig.baseUrl}/IsAccountCredentialsCorrect',
        data: {
          "login": login,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return data;
      } else {
        return {'error': 'Incorrect login or password'};
      }
    } catch (e) {
      return {'error': 'Network error occurred'};
    }
  }

  Future<void> logout() async {
    // Implement the logout logic here
  }
}
