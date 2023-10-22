import 'package:car_rental_ui/resources/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../resources/app_colors.dart';
import '../../resources/dimens.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final bool mandatory;
  final Function(String?) onChange;
  final bool? allowOnlyNumbers;
  final dynamic initialValue;
  final bool? enabled;
  final List<TextInputFormatter>? validations;
  final String placeholder;
  final bool obscureText;
  final bool hideLabel;
  final double height;
  final double? width;
  final bool? showLabel;

  const TextFieldWidget(
      {Key? key,
      required this.label,
      required this.mandatory,
      required this.onChange,
      this.allowOnlyNumbers,
      this.initialValue,
      this.enabled,
      this.validations,
      this.placeholder = 'Placeholder',
      this.obscureText = false,
      this.hideLabel = false,
      this.width,
      this.height = 75.0,
      this.showLabel})
      : super(key: key);

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
        if (showLabel ?? false)
          SizedBox(
            height: 20.0,
            child: Text(
              '$label ${mandatory ? ' *' : ''}',
              style: const TextStyle(fontSize: 16.0, color: AppColors.darkBlue, fontFamily: Fonts.trajan),
            ),
          ),
        Dimens.smallSizedBox,
        SizedBox(
          height: showLabel ?? false ? height + 20 : height,
          width: width ?? 150,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: FormBuilderTextField(
                  obscureText: obscureText,
                  enabled: enabled ?? true,
                  name: label,
                  decoration: _buildInputDecoration(label, placeholder),
                  onChanged: onChange,
                  initialValue:
                      (allowOnlyNumbers != null && allowOnlyNumbers!) ? (initialValue != null ? initialValue.toString() : '') : initialValue,
                  validator: (value) => mandatory && (value == null || value.isEmpty) ? 'Field required' : null,
                  inputFormatters: formatters,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(String label, String placeholder) {
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
      borderSide: BorderSide(
        color: AppColors.darkBlue,
      ),
    );

    return InputDecoration(
      labelText: (showLabel ?? false) ? label + (mandatory ? ' *' : '') : null,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: placeholder,
      hoverColor: Colors.white,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
      filled: (enabled != null && !(enabled!)) ? true : null,
      fillColor: (enabled != null && !(enabled!)) ? AppColors.lightBlue : null,
    );
  }
}
