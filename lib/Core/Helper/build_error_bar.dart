import 'package:flutter/material.dart';
import 'package:fruits_app/Core/utils/app_text_styles.dart';

void buildErrorBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 0, // Remove elevation (shadow) to avoid any background effects
      backgroundColor: Colors.transparent, // Fully transparent background
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
              Colors.grey,
              Colors.red,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          message,
          style: TextStyles.regular17,
        ),
      ),
    ),
  );
}
