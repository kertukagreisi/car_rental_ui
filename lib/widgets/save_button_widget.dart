import 'package:flutter/material.dart';

import '../resources/constants.dart';

class SaveButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const SaveButton({super.key, this.text = 'Save', required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: Constants.saveButtonStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.save, color: Colors.white, size: 16),
            const SizedBox(width: 2.0),
            Text(text, style: Constants.mediumHeadTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
          ],
        ));
  }
}
