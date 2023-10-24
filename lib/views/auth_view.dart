import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:peanut/controllers/auth_controller.dart';

class AuthView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5, // Add elevation for the card
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ensure the card size fits its content
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
                    SizedBox(height: 10), // Add some spacing
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
                    SizedBox(height: 20), // Add more spacing
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                      child: ElevatedButton(
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
                    ),
                    SizedBox(height: 10), // Add some more spacing
                    Obx(() {
                      if (authController.isLoading.value) {
                        return SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 50.0,
                        );
                      } else {
                        return Container(); // Empty container
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
