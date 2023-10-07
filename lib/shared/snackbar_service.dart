import 'package:flutter/material.dart';

import '../resources/dimens.dart';
import 'globals.dart';

void showSnackBar(SnackBarLevel level, String content) {
  SnackBar snackBar;
  switch (level) {
    case SnackBarLevel.error:
      snackBar = _getSnackBar(
        content,
        const Color(0xFFFAE5E5),
        Colors.red,
      );
      break;
    case SnackBarLevel.success:
      snackBar = _getSnackBar(
        content,
        const Color.fromRGBO(231, 244, 249, 1.0),
        const Color.fromRGBO(15, 141, 197, 1.0),
      );
      break;
    case SnackBarLevel.warning:
      snackBar = _getSnackBar(
        content,
        const Color(0xFFF4A34C),
        Colors.white,
      );
      break;
  }

  Globals.snackBarKey.currentState?.clearSnackBars();
  Globals.snackBarKey.currentState?.showSnackBar(snackBar);
}

SnackBar _getSnackBar(String content, Color color, Color? textColor) => SnackBar(
      content: Text(
        content,
        style: Dimens.mediumTextStyle.copyWith(color: textColor),
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      showCloseIcon: true,
      closeIconColor: textColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
    );

void onSuccessStamp(BuildContext? context, String content) {
  Globals.snackBarKey.currentState?.clearSnackBars();
  Globals.snackBarKey.currentState?.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(content),
          GestureDetector(
            onTap: () {},
            child: const SizedBox(width: 11.04, height: 11.99, child: Icon(Icons.close, size: 11)),
          ),
        ],
      ),
    ),
  );
}

enum SnackBarLevel { error, success, warning }
