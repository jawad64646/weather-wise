import 'package:flutter/material.dart';
import 'package:weatherwise/core/configs/theme/app_colors.dart';

class UnitButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const UnitButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isSelected
              ? AppColors.primaryLight
              : Colors.transparent,
          foregroundColor: isSelected ? Colors.white : AppColors.cardLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
