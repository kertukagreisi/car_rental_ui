import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../resources/app_colors.dart';
import '../../resources/dimens.dart';

class RadioButtonWidget extends StatefulWidget {
  final String label;
  final bool mandatory;
  final Function(dynamic) onChange;
  final List<String> labels;
  final String? toolTip;
  final String? initialValue;

  const RadioButtonWidget({
    required this.label,
    required this.mandatory,
    required this.onChange,
    required this.labels,
    this.toolTip,
    this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Dimens.filterButtonHeight,
      width: Dimens.filterButtonWidth,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: FormBuilderRadioGroup(
              name: widget.label,
              options: _buildFormBuilderFieldOptions(widget.labels),
              separator: const SizedBox(
                width: 6.0,
              ),
              onChanged: widget.onChange,
              // orientation: OptionsOrientation.vertical,
              decoration: _buildRadioButtonInputDecoration(widget.label),
              initialValue: widget.initialValue,
              validator: (value) => widget.mandatory && (value == null) ? 'Field required' : null,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildRadioButtonInputDecoration(String label) {
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
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
