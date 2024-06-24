import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/constants.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onPressed;
  final bool dark;

  const ButtonWithIcon({super.key, required this.text, required this.onPressed, required this.icon, required this.dark});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: dark ? Constants.saveButtonStyle : Constants.cancelButtonStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: dark ? Colors.white : AppColors.darkCyan, size: 16),
            const SizedBox(width: 2.0),
            Text(text, style: Constants.mediumTextStyle.copyWith(fontWeight: FontWeight.w500, color: dark ? Colors.white : AppColors.darkCyan)),
          ],
        ));
  }
}
