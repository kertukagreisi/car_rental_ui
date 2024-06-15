import 'package:car_rental_ui/resources/dimens.dart';
import 'package:car_rental_ui/widgets/save_button_widget.dart';
import 'package:flutter/material.dart';

import 'cancel_button_widget.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function() confirmCallback;
  final Function() cancelCallback;
  final String confirmButtonText;
  final String cancelButtonText;

  const ConfirmDialog(
      {super.key,
      required this.title,
      required this.message,
      required this.confirmCallback,
      required this.cancelCallback,
      this.confirmButtonText = 'Save',
      this.cancelButtonText = 'Cancel'});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: Dimens.headTextStyle),
      content: Text(message, style: Dimens.smallTextStyle),
      actions: [SaveButton(text: confirmButtonText, onPressed: confirmCallback), CancelButton(text: cancelButtonText, onPressed: cancelCallback)],
      titlePadding: Dimens.mediumPadding,
      contentPadding: Dimens.mediumPadding,
      actionsPadding: Dimens.mediumPadding,
    );
  }
}
