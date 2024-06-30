import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../resources/fonts.dart';

class DropDownSelectWidget extends StatefulWidget {
  final String label;
  final List<String> items;
  final Function(String?) onDropDownChange;
  final bool mandatory;
  final double? width;
  final String? toolTip;
  final String? initialValue;
  final bool enabled;
  final bool? showLabel;

  const DropDownSelectWidget({
    super.key,
    required this.label,
    required this.items,
    required this.onDropDownChange,
    required this.mandatory,
    this.width,
    this.toolTip,
    this.initialValue,
    this.enabled = true,
    this.showLabel,
  });

  @override
  State<DropDownSelectWidget> createState() => _DropDownSelectWidgetState();
}

class _DropDownSelectWidgetState extends State<DropDownSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: (widget.showLabel ?? false) ? null : 70.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.showLabel ?? false) ...[
              SizedBox(
                height: 20.0,
                child: Text(
                  '${widget.label} ${widget.mandatory ? ' *' : ''}',
                  style: const TextStyle(fontSize: 16.0, color: AppColors.darkCyan, fontFamily: Fonts.openSans),
                ),
              ),
              Constants.mediumSizedBox,
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ColoredBox(
                    color: Colors.white,
                    child: FormBuilderDropdown<String>(
                      name: widget.label,
                      initialValue: widget.initialValue,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.darkCyan,
                      ),
                      enabled: widget.items.isNotEmpty && (widget.enabled),
                      iconDisabledColor: AppColors.gray,
                      onChanged: widget.onDropDownChange,
                      items: widget.items
                          .map(
                            (defect) => DropdownMenuItem(
                              value: defect,
                              child: Text(defect),
                            ),
                          )
                          .toList(),
                      decoration: _buildInputDecoration(),
                      validator: (value) => widget.mandatory && value == null ? '${widget.label} is required' : null,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  InputDecoration _buildInputDecoration() {
    const outlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.darkCyan,
      ),
    );

    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 4.0),
      labelText: (widget.showLabel ?? false) ? widget.label + (widget.mandatory ? ' *' : '') : null,
      hintText: widget.label,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle: Constants.extraSmallTextStyle,
      labelStyle: Constants.smallHeadTextStyle.copyWith(color: AppColors.darkCyan),
      hintStyle: Constants.smallTextStyle.copyWith(color: AppColors.gray),
      errorStyle: Constants.extraSmallTextStyle.copyWith(fontSize: 8.0, color: AppColors.red),
      hoverColor: Colors.white,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
      filled: widget.enabled ? true : null,
      fillColor: widget.enabled ? AppColors.lightGray : null,
    );
  }
}
