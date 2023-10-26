import 'package:flutter/material.dart';

void showAppSnackbar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Center(child: Text(msg)),
    backgroundColor: Colors.blue,
    duration: Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
