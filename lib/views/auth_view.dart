import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:peanut/common/utils/app_colors.dart';
import 'package:peanut/common/utils/app_snackbar.dart';
import 'package:peanut/common/utils/app_txt.dart';
import 'package:peanut/controllers/auth_controller.dart';
import 'package:peanut/views/dashboard_view.dart';

class AuthView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (authController.accessToken.isNotEmpty) {
      // If authenticated then redirect to the dashboard
      return DashboardView();
    }

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: loginController,
                          decoration: InputDecoration(
                            labelText: AppText.loginLabel,
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return AppText.enterLogin;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: AppText.passwordLabel,
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return AppText.enterPassword;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            // Hide the keyboard
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState?.validate() == true) {
                              final isConnected = await authController
                                  .checkInternetConnection();
                              if (!isConnected) {
                                showAppSnackbar(
                                    context, AppText.noInternetMessage);
                                return;
                              }
                              authController.login(
                                  context,
                                  loginController.text ?? '',
                                  passwordController.text ?? '');
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.blue),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: isPortrait ? 20.0 : 40.0,
                                // Adjust padding based on orientation
                                vertical: 10.0,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: Text(
                            AppText.loginButton,
                            style: TextStyle(
                              fontSize: isPortrait ? 18.0 : 24.0,
                              // Adjust font size based on orientation
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Obx(() {
                          if (authController.isLoading.value) {
                            return SpinKitFadingCircle(
                              color: AppColors.blue,
                              size: isPortrait
                                  ? 50.0
                                  : 80.0, // Adjust loading spinner size based on orientation
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
