import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../resources/app_colors.dart';
import '../../resources/dimens.dart';

class RangeSliderWidget extends StatefulWidget {
  final String label;
  final bool mandatory;
  final Function(dynamic) onChange;
  final double min;
  final double max;
  final String? toolTip;
  final String? initialValue;

  const RangeSliderWidget({
    required this.label,
    required this.mandatory,
    required this.onChange,
    required this.min,
    required this.max,
    this.initialValue,
    this.toolTip,
    Key? key,
  }) : super(key: key);

  @override
  State<RangeSliderWidget> createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  @override
  Widget build(BuildContext context) {
    double? defaultMinValue;
    double? defaultMaxValue;
    List<String>? ranges = widget.initialValue != null ? widget.initialValue?.split('-') : [];

    if (ranges != null && ranges.isNotEmpty && ranges.length == 2) {
      defaultMinValue = double.parse(ranges[0].trim());
      defaultMaxValue = double.parse(ranges[1].trim());
    }

    return Container(
      // height: Dimens.filterButtonHeight,
      width: Dimens.filterButtonWidth,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: FormBuilderRangeSlider(
              name: widget.label,
              min: widget.min,
              max: widget.max,
              initialValue: RangeValues(defaultMinValue ?? widget.min, defaultMaxValue ?? widget.max),
              divisions: 10,
              activeColor: AppColors.darkCyan,
              inactiveColor: AppColors.lightBlue,
              decoration: _buildRangeSliderInputDecoration(widget.label),
              validator: (value) => widget.mandatory && value == null ? 'Field required' : null,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildRangeSliderInputDecoration(String label) {
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
      borderSide: BorderSide(
        color: AppColors.darkCyan,
      ),
    );
    return InputDecoration(
      labelText: label + (widget.mandatory ? ' *' : ''),
      labelStyle: Dimens.extraSmallTextStyle,
      floatingLabelStyle: Dimens.extraSmallTextStyle,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorStyle: const TextStyle(fontSize: 9, backgroundColor: AppColors.lightBlue),
      errorMaxLines: 1,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
    );
  }
}
