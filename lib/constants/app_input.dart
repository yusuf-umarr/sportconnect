import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppInput {
  static const focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
    borderSide: BorderSide(
      color: AppColors.primaryColor,
    ),
  );

  static const border = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
    borderSide: BorderSide(
      color: AppColors.primaryColor,
    ),
  );

  static const errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
    borderSide: BorderSide(
      color: Colors.red,
    ),
  );

  static const TextStyle errorStyle = TextStyle(
      fontFamily: 'Outfit', fontSize: 14, backgroundColor: Colors.transparent);
}
