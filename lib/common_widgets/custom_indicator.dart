import 'package:flutter/cupertino.dart';
import 'package:my_app/constants/app_colors.dart';

class CustomIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const CustomIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (idx) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),

          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: idx == currentPage ? AppColors.primary : AppColors.txt,
          ),
        ),
      ),
    );
  }
}
