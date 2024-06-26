import 'package:car_rental_ui/widgets/ui_type/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../resources/app_colors.dart';
import '../../resources/constants.dart';

class TextInputWidget extends StatelessWidget {
  final String label;
  final bool mandatory;
  final Function(String?) onChange;
  final bool? allowOnlyNumbers;
  final dynamic initialValue;
  final bool enabled;
  final List<TextInputFormatter>? validations;
  final String placeholder;
  final bool obscureText;
  final double height;
  final double? width;
  final bool showLabel;
  final String? inputType;
  final IconData? iconData;

  const TextInputWidget(
      {super.key,
      required this.label,
      required this.mandatory,
      required this.onChange,
      this.allowOnlyNumbers,
      this.initialValue,
      this.enabled = true,
      this.validations,
      this.placeholder = 'Placeholder',
      this.obscureText = false,
      this.width,
      this.height = 54,
      this.showLabel = true,
      this.inputType,
      this.iconData});

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> formatters = (allowOnlyNumbers != null && allowOnlyNumbers == true) ? [FilteringTextInputFormatter.digitsOnly] : [];

    if (validations != null && (validations?.isNotEmpty)!) {
      validations?.forEach((element) {
        formatters.add(element);
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: showLabel ? height + 20 : height,
          width: width,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: FormBuilderTextField(
                  obscureText: obscureText,
                  enabled: enabled,
                  name: label,
                  decoration: _buildInputDecoration(),
                  style: Constants.smallTextStyle,
                  onChanged: onChange,
                  initialValue:
                      (allowOnlyNumbers != null && allowOnlyNumbers!) ? (initialValue != null ? initialValue.toString() : '') : initialValue,
                  validator: (value) => _getValidator(value),
                  inputFormatters: formatters,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration() {
    const outlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.darkCyan,
      ),
    );

    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 4.0),
      labelText: showLabel ? label : null,
      hintText: placeholder,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle: Constants.extraSmallTextStyle,
      labelStyle: Constants.smallHeadTextStyle.copyWith(color: AppColors.darkCyan),
      hintStyle: Constants.smallTextStyle.copyWith(color: AppColors.gray),
      errorStyle: Constants.extraSmallTextStyle.copyWith(fontSize: 8.0, color: AppColors.red),
      suffixIcon: Icon(iconData, size: 16),
      iconColor: AppColors.lightGray,
      hoverColor: Colors.white,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
      filled: enabled ? true : null,
      fillColor: enabled ? AppColors.lightGray : null,
    );
  }

  String? _getValidator(String? value) {
    if (inputType == 'Phone Number') {
      return validateMobile(value ?? '');
    } else if (inputType == 'Email') {
      return validateEmail(value ?? '');
    }
    return mandatory && (value == null || value.isEmpty) ? '$label is required' : null;
  }
}
