import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class TextContainer extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color textColor;
  final Color backgroundColor;
  final Border? border;
  final double? fontSize;

  const TextContainer({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.fontWeight,
    this.border,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        border: border,
      ),
      child: Text(
        text,
        style: Dimens.extraSmallTextStyle.copyWith(fontSize: fontSize, fontWeight: fontWeight, color: textColor),
      ),
    );
  }
}
