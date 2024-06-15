import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class SaveButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const SaveButton({super.key, this.text = 'Save', required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed, style: Dimens.saveButtonStyle, child: Text(text, style: Dimens.mediumTextStyle.copyWith(color: Colors.white)));
  }
}
