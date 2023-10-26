import 'package:peanut/common/utils/app_txt.dart';
import 'package:peanut/models/account_info.dart';
import 'package:peanut/network/api_config.dart';
import 'package:peanut/network/dio.dart';

class ProfileService {
  Future<AccountInformation> getAccountInformation(
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
        return AccountInformation.fromJson(data);
      } else {
        throw Exception(AppText.unableToFetch);
      }
    } catch (e) {
      throw Exception('Error: $e');
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
        throw Exception(AppText.unableToFetchLastFourNumbers);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
