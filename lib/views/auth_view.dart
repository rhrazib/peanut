import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:peanut/common/utils/app_colors.dart';
import 'package:peanut/common/utils/custom_snackbar.dart';
import 'package:peanut/common/utils/custom_txt.dart';
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
      // The user is already authenticated; redirect to the dashboard
      return DashboardView();
    }
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: loginController,
                      decoration: InputDecoration(
                        labelText: CustomText.loginLabel,
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return CustomText.enterLogin;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: CustomText.passwordLabel,
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return CustomText.enterPassword;
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
                          final isConnected = await authController.checkInternetConnection();
                          if (!isConnected) {
                            showCustomSnackbar(context, CustomText.noInternetMessage);
                            return;
                          }
                          authController.login(context, loginController.text ?? '', passwordController.text ?? '');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors.blue),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      child: Text(
                        CustomText.loginButton,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(() {
                      if (authController.isLoading.value) {
                        return SpinKitFadingCircle(
                          color: AppColors.blue,
                          size: 50.0,
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
    );
  }
}
