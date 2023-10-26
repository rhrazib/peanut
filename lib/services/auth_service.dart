import 'package:peanut/common/utils/app_txt.dart';
import 'package:peanut/network/api_config.dart';
import 'package:peanut/network/dio.dart';

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
        return {'error': AppText.incorrectCredentials};
      }
    } catch (e) {
      return {'error': AppText.networkError};
    }
  }
}
