import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class AuthView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peanut Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: loginController,
                  decoration: InputDecoration(labelText: 'Login'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your login.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      final isConnected = await authController.checkInternetConnection();
                      if (!isConnected) {
                        Get.snackbar('No Internet', 'Please check your internet connection.',
                            backgroundColor: Colors.red, colorText: Colors.white);
                        return;
                      }
                      authController.login(loginController.text ?? '', passwordController.text ?? '');
                    }
                  },
                  child: Text('Login'),
                ),
                Obx(() {
                  if (authController.isLoading.value) {
                    return SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 50.0,
                    );
                  } else if (authController.accessToken.isNotEmpty) {
                    return Text('Access Token: ${authController.accessToken}');
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
