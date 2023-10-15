import 'package:car_rental_ui/resources/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../resources/app_colors.dart';
import '../../resources/dimens.dart';

class SingleCheckBoxWidget extends StatefulWidget {
  final String label;
  final bool mandatory;
  final String? toolTip;
  final Function(bool?) onChange;
  final bool? initialValue;
  final bool? enabled;

  const SingleCheckBoxWidget({
    required this.label,
    required this.mandatory,
    required this.onChange,
    this.toolTip,
    this.initialValue,
    this.enabled,
    Key? key,
  }) : super(key: key);

  @override
  State<SingleCheckBoxWidget> createState() => _SingleCheckBoxWidgetState();
}

class _SingleCheckBoxWidgetState extends State<SingleCheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.filterButtonWidth,
      height: 40.0,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: FormBuilderCheckbox(
              enabled: widget.enabled ?? true,
              name: widget.label,
              title: Text(
                widget.label,
                style: TextStyle(fontSize: 14.0, fontFamily: Fonts.trajan, fontWeight: FontWeight.values[3], color: AppColors.darkBlue),
              ),
              // decoration: _buildDCheckBoxInputDecoration(widget.label),
              onChanged: widget.onChange,
              initialValue: widget.initialValue,
              side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(color: AppColors.darkBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
