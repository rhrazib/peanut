import 'package:peanut/api/dio.dart';
import 'package:peanut/api/api_config.dart';

class AuthService {
  Future<Map<String, dynamic>?> login(String login, String password) async {
    try {
      final response = await DioClient.dio.post(
        '${ApiConfig.baseUrl}/IsAccountCredentialsCorrect',
        data: {
          "login": login,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }

      return null; // Indicate failure
    } catch (e) {
      return null; // Handle network errors
    }
  }
}
