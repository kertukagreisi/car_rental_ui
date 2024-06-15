import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class CancelButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const CancelButton({super.key, this.text = 'Cancel', required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, style: Dimens.cancelButtonStyle, child: Text(text, style: Dimens.mediumTextStyle));
  }
}
