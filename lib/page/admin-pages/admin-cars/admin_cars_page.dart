import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/shared/helpers.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:car_rental_ui/widgets/cancel_button_widget.dart';
import 'package:car_rental_ui/widgets/confirm_dialog_widget.dart';
import 'package:car_rental_ui/widgets/save_button_widget.dart';
import 'package:car_rental_ui/widgets/ui_type/dropdown_select_widget.dart';
import 'package:car_rental_ui/widgets/ui_type/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../resources/dimens.dart';
import 'admin_cars_view_model.dart';
import 'cars_table_datasource.dart';

class AdminCarsPage extends ViewModelWidget<AdminCarsViewModel> {
  final Map<String, String> args;

  const AdminCarsPage({super.key, required this.args});

  @override
  Widget builder(BuildContext context, AdminCarsViewModel viewModel, Widget? child) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cars Overview', style: Dimens.mediumHeadTextStyle),
            Dimens.mediumSizedBox,
            Row(
              children: [
                Expanded(
                  child: PaginatedDataTable(
                    columns: _getColumns(viewModel.columnsMap),
                    source: CarsTableDatasource(
                        cars: viewModel.cars,
                        columnsMap: viewModel.columnsMap,
                        onButtonClick: (button, id) {
                          if (button == 'edit') {
                            showDialog(context: context, builder: (context) => _showEditCarDialog(viewModel, context, button, id));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => ConfirmDialog(
                                    title: 'Delete Car',
                                    message: 'Are you sure you want to delete this car?',
                                    confirmCallback: () async {
                                      await viewModel.deleteCar(id);
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    cancelCallback: () {
                                      Navigator.of(context).pop();
                                    }));
                          }
                        }),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AlertDialog _showEditCarDialog(AdminCarsViewModel viewModel, BuildContext context, String button, int carId) {
    final formKey = GlobalKey<FormBuilderState>();
    Car car = viewModel.cars.firstWhere((car) => car.id == carId);
    return AlertDialog(
      title: const Text('Edit Car', style: Dimens.headTextStyle),
      content: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextInputWidget(label: 'model', mandatory: true, onChange: (value) {}, initialValue: car.model),
              DropDownSelectWidget(label: 'brand', items: brandValues, onDropDownChange: (value) {}, mandatory: true, initialValue: car.brand.value),
              TextInputWidget(label: 'engine', mandatory: true, onChange: (value) {}, initialValue: car.engine),
              DropDownSelectWidget(
                  label: 'fuelType', items: fuelTypeValues, onDropDownChange: (value) {}, mandatory: true, initialValue: car.fuelType.value),
              TextInputWidget(label: 'doors', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true, initialValue: car.doors),
              DropDownSelectWidget(label: 'color', items: colorValues, onDropDownChange: (value) {}, mandatory: true, initialValue: car.color.value),
              DropDownSelectWidget(
                  label: 'transmission',
                  items: transmissionValues,
                  onDropDownChange: (value) {},
                  mandatory: true,
                  initialValue: car.transmission.value),
              TextInputWidget(label: 'seats', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true, initialValue: car.seats),
              TextInputWidget(label: 'year', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true, initialValue: car.year),
              TextInputWidget(label: 'licencePlate', mandatory: true, onChange: (value) {}, initialValue: car.licencePlate),
              TextInputWidget(label: 'price', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true, initialValue: car.price),
            ],
          ),
        ),
      ),
      actions: [
        SaveButton(
            text: 'Edit',
            onPressed: () async {
              formKey.currentState?.save();
              if (formKey.currentState!.validate()) {
                await viewModel.editCar(formKey.currentState!.value, car);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            }),
        CancelButton(onPressed: () {
          Navigator.of(context).pop();
        }),
      ],
      titlePadding: Dimens.mediumPadding,
      contentPadding: Dimens.mediumPadding,
      actionsPadding: Dimens.mediumPadding,
    );
  }

  List<DataColumn> _getColumns(Map<String, String> columnsMap) {
    return columnsMap.entries
        .map((column) =>
            DataColumn(label: Text(column.value, style: Dimens.smallTextStyle.copyWith(fontWeight: FontWeight.w600)), tooltip: column.value))
        .toList();
  }

  @override
  AdminCarsViewModel viewModelBuilder() {
    return getIt.get<AdminCarsViewModel>(param1: args);
  }
}
