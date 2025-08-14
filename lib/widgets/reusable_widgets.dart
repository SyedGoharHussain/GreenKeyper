import 'package:flutter/material.dart';
import 'package:greenkeyper/theme/colors.dart';

class ReusableWidgets {
  static Widget authHeader(String title, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(
          child: Text(
            "LOGO",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.tealPrimary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const SizedBox.shrink(),
        const SizedBox(height: 0),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Center(
            child: Text(
              subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ],
    );
  }

  static Widget gradientButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: AppColors.gradientTealCenter,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: isLoading ? null : onPressed,
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  static Widget authFooter({
    required String text,
    required String actionText,
    required VoidCallback onAction,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onAction,
          child: Text(
            actionText,
            style: const TextStyle(
              color: AppColors.tealPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
