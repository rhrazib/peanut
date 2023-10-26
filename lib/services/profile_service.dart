import 'package:peanut/common/utils/app_txt.dart';
import 'package:peanut/network/api_config.dart';
import 'package:peanut/network/dio.dart';

class ProfileService {
  Future<Map<String, dynamic>> getAccountInformation(
      String accessToken, String login) async {
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
        return {'error': AppText.unableToFetch};
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }

  Future<String> getLastFourNumbersPhone(
      String accessToken, String login) async {
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
        return AppText.unableToFetchLastFourNumbers;
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
