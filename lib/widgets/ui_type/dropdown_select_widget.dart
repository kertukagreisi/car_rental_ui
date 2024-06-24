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
  final String? toolTip;
  final String? initialValue;
  final bool? enabled;
  final bool? showLabel;

  const DropDownSelectWidget({
    super.key,
    required this.label,
    required this.items,
    required this.onDropDownChange,
    required this.mandatory,
    this.toolTip,
    this.initialValue,
    this.enabled,
    this.showLabel,
  });

  @override
  State<DropDownSelectWidget> createState() => _DropDownSelectWidgetState();
}

class _DropDownSelectWidgetState extends State<DropDownSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Constants.filterButtonWidth,
        height: (widget.showLabel ?? false) ? null : 60.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.showLabel ?? false)
              SizedBox(
                height: 20.0,
                child: Text(
                  '${widget.label} ${widget.mandatory ? ' *' : ''}',
                  style: const TextStyle(fontSize: 16.0, color: AppColors.darkCyan, fontFamily: Fonts.openSans),
                ),
              ),
            if (widget.showLabel ?? false) Constants.mediumSizedBox,
            Row(
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
                      enabled: widget.items.isNotEmpty && (widget.enabled ?? true),
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
                      decoration: _buildInputDecoration(widget.label),
                      validator: (value) => widget.mandatory && value == null ? 'Field required' : null,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  InputDecoration _buildInputDecoration(String label) {
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
      borderSide: BorderSide(
        color: AppColors.darkCyan,
      ),
    );

    return InputDecoration(
      labelText: (widget.showLabel ?? false) ? label + (widget.mandatory ? ' *' : '') : null,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: 'Select',
      hoverColor: Colors.white,
      contentPadding: const EdgeInsets.only(
        left: 16,
        bottom: 11,
        top: 11,
        right: 16,
      ),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
    );
  }
}
