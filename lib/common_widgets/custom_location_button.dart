
import 'package:flutter/material.dart';
import 'package:my_app/constants/app_colors.dart';

class CustomLocationButton extends StatelessWidget {
  final VoidCallback? onClick;
  final String btnText;
  final IconData? icon;
  const CustomLocationButton({
    super.key,
    required this.btnText,
    this.onClick,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle location permission request
          onClick?.call();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.btnBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              btnText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Icon(icon, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
