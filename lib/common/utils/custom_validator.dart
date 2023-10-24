import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  String title = '', // Provide a default value for title
  String message ='',
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
  );
}


