import 'package:flutter/material.dart';
import 'package:peanut/common/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onPressed;

  CustomButton({
    required this.title,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(context).size.width / 4
                : MediaQuery.of(context).size.width / 2,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blue900,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: AppColors.white,
                  size: 36,
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
