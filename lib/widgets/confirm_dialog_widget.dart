import 'package:car_rental_ui/resources/constants.dart';
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
      title: Container(
          padding: Constants.smallPadding,
          decoration: Constants.popUpHeaderDecoration,
          child: Text(title, style: Constants.mediumHeadTextStyle.copyWith(color: Colors.white))),
      content: Container(color: Colors.white, padding: Constants.mediumPadding, child: Text(message, style: Constants.smallTextStyle)),
      actions: [
        Container(
          padding: Constants.mediumPadding,
          decoration: const BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SaveButton(text: confirmButtonText, onPressed: confirmCallback),
              Constants.smallSizedBox,
              CancelButton(text: cancelButtonText, onPressed: cancelCallback),
            ],
          ),
        )
      ],
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      actionsPadding: const EdgeInsets.all(0),
    );
  }
}
