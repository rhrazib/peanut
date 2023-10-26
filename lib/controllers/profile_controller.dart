import 'package:get/get.dart';
import 'package:peanut/models/account_info.dart';
import 'package:peanut/services/profile_service.dart';

class ProfileController extends GetxController {
  final ProfileService profileService =
      ProfileService(); // Create an instance of the profile service

  Future<AccountInformation> getAccountInformation(
      String accessToken, String login) async {
    return profileService.getAccountInformation(accessToken, login);
  }

  Future<String> getLastFourNumbersPhone(
      String accessToken, String login) async {
    return profileService.getLastFourNumbersPhone(accessToken, login);
  }
}
