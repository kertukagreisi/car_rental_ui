import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../resources/app_colors.dart';
import '../../resources/constants.dart';

class DatePickerWidget extends StatefulWidget {
  final String label;
  final bool mandatory;
  final Function(dynamic) onChange;
  final String? toolTip;
  final double? width;
  final bool enabled;
  final IconData? iconData;
  final bool? startsFromToday;
  final dynamic initialValue;

  const DatePickerWidget({
    required this.label,
    required this.mandatory,
    required this.onChange,
    this.toolTip,
    this.width,
    this.enabled = true,
    this.iconData,
    this.startsFromToday,
    super.key,
    this.initialValue,
  });

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
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
              initialValue: widget.initialValue ?? DateTime.now(),
              firstDate: (widget.startsFromToday ?? false) ? DateTime.now() : null,
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
    const outlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.darkCyan,
      ),
    );
    return InputDecoration(
      labelText: label + (widget.mandatory ? ' *' : ''),
      hintText: 'mm/dd/yyyy',
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: Constants.smallHeadTextStyle.copyWith(color: AppColors.darkCyan),
      floatingLabelStyle: Constants.extraSmallTextStyle,
      hintStyle: Constants.smallTextStyle.copyWith(color: AppColors.gray),
      errorStyle: Constants.extraSmallTextStyle.copyWith(fontSize: 8.0, color: AppColors.red),
      suffixIcon: Icon(widget.iconData, size: 16),
      iconColor: AppColors.lightGray,
      hoverColor: Colors.white,
      errorMaxLines: 1,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
      filled: widget.enabled ? true : null,
      fillColor: widget.enabled ? AppColors.lightGray : null,
    );
  }
}
