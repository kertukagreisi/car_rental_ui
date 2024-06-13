import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';

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
            const Text('Cars Overview', style: Dimens.smallHeadTextStyle),
            PaginatedDataTable(columns: _getColumns(viewModel.columnsMap), source: CarTableDatasource(cars: viewModel.cars))
          ],
        ),
      ),
    );
  }

  _getColumns(Map<String, String> columnsMap) {
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
