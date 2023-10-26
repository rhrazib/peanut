import 'package:peanut/network/api_config.dart';

class AppText {
  static const String loginLabel = 'Login';
  static const String passwordLabel = 'Password';
  static const String loginButton = ' Login ';
  static const String noInternetMessage =
      'No Internet, Please check your internet connection.';
  static const String enterLogin = 'Please enter your login.';
  static const String enterPassword = 'Please enter your password.';

  static const String incorrectCredentials =
      'Incorrect login or password, try again';
  static const String networkError = 'Network error occurred';

  static const String loginFailed = 'Login Failed';
  static const String loginError = 'Incorrect login or password, try again.';
  static const String unauthorizedAccess = 'Unauthorized access.';
  static const String serverError = 'Server Error';
  static const String internalServerError = 'Internal server error occurred.';
  static const String accessDenied = 'Access denied';
  static const String badRequest = 'Bad Request';
  static const String invalidRequest = 'Invalid request.';
  static const String genericError = 'An error occurred.';

  static const String errorMessage = 'Error';
  static const String networkErrorMessage = 'Network error occurred';

  static const String unableToFetch = 'Unable to fetch trades information';
  static const String unableToFetchLastFourNumbers =
      'Unable to fetch last four numbers';
  static const String unableToFetchLastUserTrades =
      'Unable to fetch user trades';

  static const String authApi =
      '${ApiConfig.baseUrl}/IsAccountCredentialsCorrect';
  static const String promotionalCampaigns = 'Promotional campaigns';
  static const String userProfile = 'User Profile';
  static const String pleaseLoginToViewInfo =
      'Please log in to view user information.';

  static const String lastFourNumbersOfPhone = 'Last Four Numbers of Phone';
  static const String userInformation = 'User Information';
}
