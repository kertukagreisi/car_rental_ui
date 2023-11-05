import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:flutter/material.dart';

class Helpers {
  static Color getTextColor(bool isMainColor, String value) {
    if (isMainColor) {
      switch (value) {
        case 'BEIGE':
          return const Color(0xFF542031);
        case 'BLACK':
          return Colors.black;
        case 'CHROME':
          return Colors.black45;
        case 'GRAY':
          return Colors.black12;
        case 'GREEN':
          return Colors.green;
        case 'RED':
          return AppColors.darkRed;
        case 'YELLOW':
          return Colors.yellow;
        case 'WHITE':
          return Colors.white;
        default:
          return AppColors.darkCyan;
      }
    } else {
      switch (value) {
        case 'BEIGE':
          return Colors.white;
        case 'BLACK':
          return Colors.white;
        case 'CHROME':
          return Colors.white;
        case 'GRAY':
          return Colors.white;
        case 'GREEN':
          return Colors.white;
        case 'RED':
          return Colors.white;
        case 'YELLOW':
          return AppColors.darkCyan;
        case 'WHITE':
          return AppColors.darkCyan;
        default:
          return Colors.white;
      }
    }
  }
}
