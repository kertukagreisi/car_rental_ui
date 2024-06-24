import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../resources/app_colors.dart';
import '../../resources/constants.dart';

class DateTimePickerWidget extends StatefulWidget {
  final String label;
  final bool mandatory;
  final Function(dynamic) onChange;
  final String? toolTip;

  const DateTimePickerWidget({
    required this.label,
    required this.mandatory,
    required this.onChange,
    this.toolTip,
    super.key,
  });

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.filterButtonHeight,
      width: Constants.filterButtonWidth,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: FormBuilderDateTimePicker(
              name: widget.label,
              initialValue: DateTime.now(),
              format: DateFormat('yyyy-MM-dd HH:mm'),
              decoration: _buildDatePickerInputDecoration(widget.label),
              validator: (value) => widget.mandatory && value == null ? 'Field required' : null,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildDatePickerInputDecoration(String label) {
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
      borderSide: BorderSide(
        color: AppColors.darkCyan,
      ),
    );
    return InputDecoration(
      labelText: label + (widget.mandatory ? ' *' : ''),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: 'mm/dd/yyyy - mm/dd/yyyy',
      floatingLabelStyle: Constants.extraSmallTextStyle,
      labelStyle: Constants.mediumTextStyle.copyWith(
        color: Colors.black,
      ),
      errorStyle: const TextStyle(fontSize: 9, backgroundColor: AppColors.lightBlue),
      errorMaxLines: 1,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
    );
  }
}
