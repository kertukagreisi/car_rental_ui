import 'package:car_wash_ui/resources/dimens.dart';
import 'package:car_wash_ui/shared/locator.dart';
import 'package:car_wash_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'cars_view_model.dart';

class CarsPage extends ViewModelWidget<CarsViewModel> {
  const CarsPage({super.key});

  List<PlutoColumn> _getColumns(Map<String, String> columnNames) {
    List<PlutoColumn> columns = [];
    columnNames.forEach(
      (key, value) => columns.add(PlutoColumn(title: value, field: key, type: PlutoColumnType.text())),
    );
    return columns;
  }

  List<PlutoRow> _getRows(List<dynamic> cars) {
    return cars
        .map((car) => PlutoRow(
              cells: {
                'id': PlutoCell(value: '${car['id']}'),
                'model': PlutoCell(value: car['model']),
                'year': PlutoCell(value: '${car['year']}'),
                'owner': PlutoCell(value: '${car['owner']['firstName']} ${car['owner']['lastName']}'),
              },
            ))
        .toList(growable: false);
  }

  List<PlutoColumnGroup>? _getColumnGroups() {
    return [
      PlutoColumnGroup(title: 'Id', fields: ['id'], expandedColumn: true),
      PlutoColumnGroup(title: 'Owner information', fields: ['owner'], expandedColumn: true),
      PlutoColumnGroup(title: 'Car Information', children: [
        PlutoColumnGroup(title: 'Model', fields: ['model'], expandedColumn: true),
        PlutoColumnGroup(title: 'Year', fields: ['year'], expandedColumn: true),
      ]),
    ];
  }

  @override
  Widget builder(BuildContext context, CarsViewModel viewModel, Widget? child) {
    late final PlutoGridStateManager stateManager;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32.0, left: 32.0),
                    child: Text('You have ${viewModel.cars.length} cars registered in the database!', style: Dimens.mediumHeadTextStyle),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 1000,
              height: 1000,
              child: PlutoGrid(
                columns: _getColumns(viewModel.columnNames),
                rows: _getRows(viewModel.cars),
                columnGroups: _getColumnGroups(),
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                  stateManager.setShowColumnFilter(true);
                },
                onChanged: (PlutoGridOnChangedEvent event) {},
                configuration: const PlutoGridConfiguration(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  CarsViewModel viewModelBuilder() {
    return getIt.get<CarsViewModel>();
  }
}
