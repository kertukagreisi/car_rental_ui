import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:flutter/material.dart';

import '../resources/constants.dart';

class CancelButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const CancelButton({super.key, this.text = 'Cancel', required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: Constants.cancelButtonStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.close, color: AppColors.darkCyan, size: 16),
            const SizedBox(width: 2.0),
            Text(text, style: Constants.mediumTextStyle.copyWith(fontWeight: FontWeight.w500)),
          ],
        ));
  }
}
