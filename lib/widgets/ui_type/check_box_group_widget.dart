import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../resources/app_colors.dart';
import '../../resources/dimens.dart';

class CheckBoxGroupWidget extends StatefulWidget {
  final String label;
  final bool mandatory;
  final Function(String?) onChange;
  final List<String> labels;

  const CheckBoxGroupWidget({
    required this.label,
    required this.mandatory,
    required this.onChange,
    required this.labels,
    Key? key,
  }) : super(key: key);

  @override
  State<CheckBoxGroupWidget> createState() => _CheckBoxGroupWidgetState();
}

class _CheckBoxGroupWidgetState extends State<CheckBoxGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Dimens.filterButtonHeight,
      width: Dimens.filterButtonWidth,
      color: Colors.white,
      child: FormBuilderCheckboxGroup(
        name: widget.label,
        decoration: _buildDCheckBoxInputDecoration(widget.label),
        options: _buildFormBuilderFieldOptions(widget.labels),
      ),
    );
  }

  InputDecoration _buildDCheckBoxInputDecoration(String label) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.darkCyan,
      ),
    );
    return InputDecoration(
      labelText: label + (widget.mandatory ? ' *' : ''),
      floatingLabelStyle: Dimens.extraSmallTextStyle,
      labelStyle: Dimens.mediumTextStyle.copyWith(
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

  List<FormBuilderFieldOption> _buildFormBuilderFieldOptions(List<String> labels) {
    List<FormBuilderFieldOption> formBuilderFieldOptionsList = [];
    for (String opt in labels) {
      formBuilderFieldOptionsList.add(
        FormBuilderFieldOption(
          value: opt,
          child: Text(opt),
        ),
      );
    }

    return formBuilderFieldOptionsList;
  }
}
