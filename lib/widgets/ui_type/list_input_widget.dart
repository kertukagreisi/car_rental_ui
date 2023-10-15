import 'package:car_rental_ui/resources/fonts.dart';
import 'package:car_rental_ui/widgets/text_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../resources/app_colors.dart';
import '../../resources/dimens.dart';

class ListInputWidget extends StatefulWidget {
  final String label;
  final bool mandatory;
  final Function(List<String>?) onChange;
  final bool? disabled;
  final List<String>? initialValue;

  const ListInputWidget({
    Key? key,
    required this.label,
    required this.mandatory,
    required this.onChange,
    this.disabled,
    this.initialValue,
  }) : super(key: key);

  @override
  State<ListInputWidget> createState() => _ListInputWidgetState();
}

class _ListInputWidgetState extends State<ListInputWidget> {
  final ValueNotifier<List<String>> valueListenableInputs = ValueNotifier<List<String>>([]);
  String valueToBeAdded = '';

  @override
  void initState() {
    super.initState();
    valueListenableInputs.value = widget.initialValue?.toList(growable: true) ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.filterButtonWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
            valueListenable: valueListenableInputs,
            builder: (BuildContext context, value, Widget? child) {
              return value.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextContainer(
                        text: 'There are no values for ${widget.label} input field!',
                        textColor: AppColors.darkBlue,
                        backgroundColor: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 18.0,
                      ),
                    )
                  : Wrap(
                      children: [
                        ...value.map(
                          (input) => Padding(
                            padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
                            child: TextContainer(
                              text: input,
                              textColor: AppColors.darkBlue,
                              backgroundColor: AppColors.lightBlue,
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40.0,
                  child: FormBuilderTextField(
                    style: const TextStyle(
                      fontFamily: Fonts.trajan,
                    ),
                    enabled: (widget.disabled == true) ? false : true,
                    initialValue: '',
                    name: widget.label,
                    decoration: _buildInputDecoration(widget.label, context),
                    onChanged: (value) {
                      valueToBeAdded = value ?? '';
                    },
                    onSubmitted: (value) {
                      List<String> values = valueListenableInputs.value.toList(growable: true);
                      values.add(valueToBeAdded);
                      valueListenableInputs.value = values;
                      widget.onChange(valueListenableInputs.value);
                    },
                    validator: (value) => widget.mandatory && (value == null || value.isEmpty) ? 'Field required' : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
      borderSide: BorderSide(
        color: AppColors.darkBlue,
      ),
    );

    return InputDecoration(
      labelText: label + (widget.mandatory ? ' *' : ''),
      floatingLabelStyle: Dimens.extraSmallTextStyle,
      errorStyle: const TextStyle(fontSize: 9.0, height: 1.0),
      errorMaxLines: 1,
      hoverColor: Colors.white,
      contentPadding: const EdgeInsets.only(
        left: 10,
        bottom: 30,
        top: 20,
        right: 10,
      ),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
    );
  }
}
