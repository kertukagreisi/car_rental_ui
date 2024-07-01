import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/constants.dart';
import 'globals.dart';

void showSnackBar(SnackBarLevel level, String content) {
  SnackBar snackBar;
  switch (level) {
    case SnackBarLevel.error:
      snackBar = _getSnackBar(
        Icons.error_outline,
        content,
        AppColors.lightRed,
        AppColors.red,
      );
      break;
    case SnackBarLevel.success:
      snackBar = _getSnackBar(
        null,
        content,
        AppColors.lightGreen,
        AppColors.green,
      );
      break;
    case SnackBarLevel.warning:
      snackBar = _getSnackBar(
        Icons.warning_amber,
        content,
        AppColors.orange,
        AppColors.lightOrange,
      );
      break;
  }

  Globals.snackBarKey.currentState?.clearSnackBars();
  Globals.snackBarKey.currentState?.showSnackBar(snackBar);
}

SnackBar _getSnackBar(IconData? iconData, String content, Color color, Color? textColor) => SnackBar(
      content: Row(
        children: [
          if (iconData != null) ...[
            Icon(iconData, color: textColor, size: 18),
            Constants.smallSizedBox,
          ],
          Text(
            content,
            style: Constants.smallTextStyle.copyWith(color: textColor),
          ),
        ],
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      showCloseIcon: true,
      closeIconColor: textColor,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    );

enum SnackBarLevel { error, success, warning }
