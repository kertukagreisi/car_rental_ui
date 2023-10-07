import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../resources/app_colors.dart';
import '../../resources/dimens.dart';

class DatePickerWidget extends StatefulWidget {
  final String label;
  final bool mandatory;
  final Function(dynamic) onChange;
  final String? toolTip;
  final dynamic initialValue;

  const DatePickerWidget({
    required this.label,
    required this.mandatory,
    required this.onChange,
    this.toolTip,
    Key? key,
    this.initialValue,
  }) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.filterButtonHeight,
      width: Dimens.filterButtonWidth,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: FormBuilderDateTimePicker(
              name: widget.label,
              initialValue: widget.initialValue ?? DateTime.now(),
              inputType: InputType.date,
              format: DateFormat('yyyy-MM-dd'),
              decoration: _buildDatePickerInputDecoration(widget.label),
              validator: (value) => widget.mandatory && value == null ? 'Field required' : null,
              onChanged: widget.onChange,
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
        color: AppColors.darkBlue,
      ),
    );
    return InputDecoration(
      labelText: label + (widget.mandatory ? ' *' : ''),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: 'mm/dd/yyyy',
      floatingLabelStyle: Dimens.extraSmallTextStyle,
      labelStyle: Dimens.extraSmallTextStyle,
      errorStyle: const TextStyle(fontSize: 9, backgroundColor: AppColors.lightBlue),
      errorMaxLines: 1,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
    );
  }
}
