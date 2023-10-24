import 'package:peanut/api/dio.dart';
import 'package:peanut/api/api_config.dart';
class ProfileService {
  Future<Map<String, dynamic>> getAccountInformation(String accessToken, String login) async {
    try {
      final response = await DioClient.dio.post(
        '${ApiConfig.baseUrl}/GetAccountInformation',
        data: {
          "login": login,
          "token": accessToken,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return data;
      } else {
        return {'error': 'Unable to fetch account information'};
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }

  Future<String> getLastFourNumbersPhone(String accessToken, String login) async {
    try {
      final response = await DioClient.dio.post(
        '${ApiConfig.baseUrl}/GetLastFourNumbersPhone',
        data: {
          "login": login,
          "token": accessToken,
        },
      );

      if (response.statusCode == 200) {
        final String lastFourNumbers = response.data;
        return lastFourNumbers;
      } else {
        return 'Unable to fetch last four numbers';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}