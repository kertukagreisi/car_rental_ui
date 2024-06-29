import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/navigation/nav_extensions.dart';
import 'package:car_rental_ui/navigation/nav_route.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:car_rental_ui/widgets/save_button_widget.dart';
import 'package:car_rental_ui/widgets/ui_type/date_picker_widget.dart';
import 'package:car_rental_ui/widgets/ui_type/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../widgets/cancel_button_widget.dart';
import 'rent_view_model.dart';

class RentPage extends ViewModelWidget<RentViewModel> {
  final Map<String, String> args;
  final Car? carFromExtraParameters;

  const RentPage({super.key, required this.args, required this.carFromExtraParameters});

  @override
  Widget builder(BuildContext context, RentViewModel viewModel, Widget? child) {
    final formKey = GlobalKey<FormBuilderState>();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Text('Select your options', style: Constants.headTextStyle),
            ),
            _buildInputFields(viewModel, formKey),
            if (viewModel.datesDifference <= 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'The end date should be after the start date!',
                  style: Constants.smallTextStyle.copyWith(color: AppColors.red),
                ),
              ),
            _buildButtonsWidget(viewModel, context, formKey)
          ],
        ),
      ),
    );
  }

  Widget _buildInputFields(RentViewModel viewModel, GlobalKey<FormBuilderState> formKey) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextInputWidget(
                    initialValue: viewModel.user.name,
                    label: 'Name',
                    mandatory: true,
                    onChange: (value) {},
                    showLabel: true,
                    iconData: Icons.person,
                  ),
                ),
                Constants.largeSizedBox,
                Expanded(
                  child: TextInputWidget(
                    initialValue: viewModel.user.lastName,
                    label: 'Last Name',
                    mandatory: true,
                    onChange: (value) {},
                    showLabel: true,
                    iconData: Icons.person,
                  ),
                ),
              ],
            ),
            TextInputWidget(
              initialValue: viewModel.user.email,
              label: 'Email',
              mandatory: true,
              onChange: (value) {},
              showLabel: true,
              iconData: Icons.email,
            ),
            TextInputWidget(
              initialValue: viewModel.user.phone,
              label: 'Phone',
              mandatory: true,
              onChange: (value) {},
              showLabel: true,
              iconData: Icons.phone,
            ),
            Row(
              children: [
                Expanded(
                  child: DatePickerWidget(
                      initialValue: viewModel.startDate,
                      label: 'Start Date',
                      mandatory: true,
                      startsFromToday: true,
                      onChange: (value) {
                        viewModel.setTotalToBePayed(true, value);
                      },
                      iconData: Icons.calendar_month),
                ),
                Constants.largeSizedBox,
                Expanded(
                  child: DatePickerWidget(
                      initialValue: viewModel.endDate,
                      label: 'End Date',
                      mandatory: true,
                      startsFromToday: true,
                      onChange: (value) {
                        viewModel.setTotalToBePayed(false, value);
                      },
                      iconData: Icons.calendar_month),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtonsWidget(RentViewModel viewModel, BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          viewModel.totalPrice >= 0 ? Text('Total: ${viewModel.totalPrice} €', style: Constants.headTextStyle): const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SaveButton(
                      text: 'Rent',
                      onPressed: () async {
                        if (viewModel.datesDifference > 0) {
                          formKey.currentState?.save();
                          if (formKey.currentState!.validate()) {
                            await viewModel.rentCar(formKey.currentState!.value, context);
                          }
                        }
                      }),
                ),
                CancelButton(onPressed: () {
                  context.goNamedRoute(NavRoute.carDetails, queryParams: args);
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  RentViewModel viewModelBuilder() {
    return getIt.get<RentViewModel>(param1: args, param2: carFromExtraParameters);
  }
}
