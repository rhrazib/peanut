import 'package:get/get.dart';
import 'package:peanut/api/dio.dart';
import 'package:peanut/api/api_config.dart';
import 'package:peanut/common/utils/custom_txt.dart';

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
        return {'error': CustomText.incorrectCredentials};
      }
    } catch (e) {
      return {'error': CustomText.networkError};
    }
  }
}
