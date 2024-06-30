import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/shared/helpers.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:car_rental_ui/widgets/button_with_icon_widget.dart';
import 'package:car_rental_ui/widgets/cancel_button_widget.dart';
import 'package:car_rental_ui/widgets/confirm_dialog_widget.dart';
import 'package:car_rental_ui/widgets/save_button_widget.dart';
import 'package:car_rental_ui/widgets/ui_type/dropdown_select_widget.dart';
import 'package:car_rental_ui/widgets/ui_type/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../resources/constants.dart';
import 'admin_cars_view_model.dart';
import 'cars_table_datasource.dart';

class AdminCarsPage extends ViewModelWidget<AdminCarsViewModel> {
  final Map<String, String> args;

  const AdminCarsPage({super.key, required this.args});

  @override
  Widget builder(BuildContext context, AdminCarsViewModel viewModel, Widget? child) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Cars Overview', style: Constants.mediumHeadTextStyle),
                ButtonWithIcon(
                    text: 'Add Car',
                    onPressed: () {
                      showDialog(context: context, builder: (context) => _showAddCarDialog(viewModel, context));
                    },
                    icon: Icons.add,
                    dark: false)
              ],
            ),
            Constants.largeSizedBox,
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
                                    confirmButtonText: 'Yes',
                                    cancelButtonText: 'No',
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

  AlertDialog _showAddCarDialog(AdminCarsViewModel viewModel, BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      actionsPadding: const EdgeInsets.all(0.0),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Container(
                  padding: Constants.mediumPadding,
                  decoration: Constants.popUpHeaderDecoration,
                  child: Text('Add Car', style: Constants.headTextStyle.copyWith(color: Colors.white)))),
        ],
      ),
      content: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextInputWidget(label: 'Model', mandatory: true, onChange: (value) {}),
                DropDownSelectWidget(label: 'Brand', items: brandValues, onDropDownChange: (value) {}, mandatory: true),
                TextInputWidget(label: 'Engine', mandatory: true, onChange: (value) {}),
                DropDownSelectWidget(label: 'Fuel Type', items: fuelTypeValues, onDropDownChange: (value) {}, mandatory: true),
                TextInputWidget(label: 'Doors', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true),
                DropDownSelectWidget(label: 'Color', items: colorValues, onDropDownChange: (value) {}, mandatory: true),
                DropDownSelectWidget(label: 'Transmission', items: transmissionValues, onDropDownChange: (value) {}, mandatory: true),
                TextInputWidget(label: 'Seats', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true),
                TextInputWidget(label: 'Year', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true),
                TextInputWidget(label: 'Licence Plate', mandatory: true, onChange: (value) {}),
                TextInputWidget(label: 'Price', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4.0), bottomRight: Radius.circular(4.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              SaveButton(
                  text: 'Add',
                  onPressed: () async {
                    formKey.currentState?.save();
                    if (formKey.currentState!.validate()) {
                      await viewModel.addCar(formKey.currentState!.value);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  }),
              Constants.smallSizedBox,
              CancelButton(onPressed: () {
                Navigator.of(context).pop();
              }),
            ],
          ),
        ),
      ],
    );
  }

  AlertDialog _showEditCarDialog(AdminCarsViewModel viewModel, BuildContext context, String button, int carId) {
    final formKey = GlobalKey<FormBuilderState>();
    Car car = viewModel.cars.firstWhere((car) => car.id == carId);
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      actionsPadding: const EdgeInsets.all(0.0),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Container(
                  padding: Constants.mediumPadding,
                  decoration: Constants.popUpHeaderDecoration,
                  child: Text('Edit Car', style: Constants.headTextStyle.copyWith(color: Colors.white)))),
        ],
      ),
      content: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextInputWidget(label: 'Model', mandatory: true, onChange: (value) {}, initialValue: car.model),
                DropDownSelectWidget(
                    label: 'Brand', items: brandValues, onDropDownChange: (value) {}, mandatory: true, initialValue: car.brand.value),
                TextInputWidget(label: 'Engine', mandatory: true, onChange: (value) {}, initialValue: car.engine),
                DropDownSelectWidget(
                    label: 'Fuel Type', items: fuelTypeValues, onDropDownChange: (value) {}, mandatory: true, initialValue: car.fuelType.value),
                TextInputWidget(label: 'Doors', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true, initialValue: car.doors),
                DropDownSelectWidget(
                    label: 'Color', items: colorValues, onDropDownChange: (value) {}, mandatory: true, initialValue: car.color.value),
                DropDownSelectWidget(
                    label: 'Transmission',
                    items: transmissionValues,
                    onDropDownChange: (value) {},
                    mandatory: true,
                    initialValue: car.transmission.value),
                TextInputWidget(label: 'Seats', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true, initialValue: car.seats),
                TextInputWidget(label: 'Year', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true, initialValue: car.year),
                TextInputWidget(label: 'Licence Plate', mandatory: true, onChange: (value) {}, initialValue: car.licencePlate),
                TextInputWidget(label: 'Price', mandatory: true, onChange: (value) {}, allowOnlyNumbers: true, initialValue: car.price),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4.0), bottomRight: Radius.circular(4.0))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
              Constants.smallSizedBox,
              CancelButton(onPressed: () {
                Navigator.of(context).pop();
              }),
            ],
          ),
        ),
      ],
    );
  }

  List<DataColumn> _getColumns(Map<String, String> columnsMap) {
    return columnsMap.entries
        .map((column) =>
            DataColumn(label: Text(column.value, style: Constants.smallTextStyle.copyWith(fontWeight: FontWeight.w600)), tooltip: column.value))
        .toList();
  }

  @override
  AdminCarsViewModel viewModelBuilder() {
    return getIt.get<AdminCarsViewModel>(param1: args);
  }
}
