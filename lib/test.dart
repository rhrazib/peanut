import 'package:get/get.dart';
import 'package:peanut/api/api_config.dart';

class ProfileController extends GetxController {
  final ProfileService profileService = ProfileService();

  Future<Map<String, dynamic>> getAccountInformation(
      String accessToken, String login) async {
    return profileService.getAccountInformation(accessToken, login);
  }

  Future<String> getLastFourNumbersPhone(
      String accessToken, String login) async {
    return profileService.getLastFourNumbersPhone(accessToken, login);
  }
}
