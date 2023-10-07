import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../resources/dimens.dart';

class SwitchWidget extends StatefulWidget {
  final String label;
  final bool mandatory;
  final Function(bool?) onChange;
  final String? toolTip;
  final bool? initialValue;
  final bool? noSizeConstraints;

  const SwitchWidget({
    required this.label,
    required this.mandatory,
    required this.onChange,
    this.toolTip,
    this.initialValue,
    this.noSizeConstraints,
    Key? key,
  }) : super(key: key);

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.noSizeConstraints != null && widget.noSizeConstraints! ? 200.0 : Dimens.filterButtonWidth,
      height: widget.noSizeConstraints != null && widget.noSizeConstraints! ? 50.0 : null,
      child: Row(
        children: [
          Expanded(
            child: FormBuilderSwitch(
              name: widget.label,
              title: Text(
                widget.label,
                style: Dimens.mediumTextStyle,
              ),
              decoration: _buildSwitchInputDecoration(widget.label),
              onChanged: widget.onChange,
              controlAffinity: ListTileControlAffinity.leading,
              initialValue: widget.initialValue,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildSwitchInputDecoration(String label) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
    );
    return const InputDecoration(
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
    );
  }
}
