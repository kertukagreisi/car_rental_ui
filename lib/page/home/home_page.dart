import 'package:car_wash_ui/resources/dimens.dart';
import 'package:car_wash_ui/shared/locator.dart';
import 'package:car_wash_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'home_view_model.dart';

class HomePage extends ViewModelWidget<HomeViewModel> {
  const HomePage({super.key});

  List<PlutoColumn> _getColumns(Map<String, String> columnNames) {
    List<PlutoColumn> columns = [];
    columnNames.forEach(
      (key, value) => columns.add(PlutoColumn(title: value, field: key, type: PlutoColumnType.text())),
    );
    return columns;
  }

  List<PlutoRow> _getRows(List<dynamic> owners) {
    return owners
        .map((owner) => PlutoRow(
              cells: {
                'id': PlutoCell(value: '${owner['id']}'),
                'firstName': PlutoCell(value: owner['firstName']),
                'lastName': PlutoCell(value: '${owner['lastName']}'),
                'phoneNumber': PlutoCell(value: '${owner['phoneNumber']}'),
                'age': PlutoCell(value: '${owner['age']}'),
              },
            ))
        .toList(growable: false);
  }

  List<PlutoColumnGroup>? _getColumnGroups() {
    return [
      PlutoColumnGroup(title: 'Owner information', children: [
        PlutoColumnGroup(title: 'id', fields: ['id'], expandedColumn: true),
        PlutoColumnGroup(title: 'firstName', fields: ['firstName'], expandedColumn: true),
        PlutoColumnGroup(title: 'lastName', fields: ['lastName'], expandedColumn: true),
        PlutoColumnGroup(title: 'phoneNumber', fields: ['phoneNumber'], expandedColumn: true),
        PlutoColumnGroup(title: 'age', fields: ['age'], expandedColumn: true),
      ]),
    ];
  }

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
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
                    child: Text('You have ${viewModel.owners.length} owners registered on the database!', style: Dimens.mediumHeadTextStyle),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 1000,
                    child: PlutoGrid(
                      columns: _getColumns(viewModel.columnNames),
                      rows: _getRows(viewModel.owners),
                      columnGroups: _getColumnGroups(),
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        stateManager = event.stateManager;
                        stateManager.setShowColumnFilter(true);
                      },
                      onChanged: (PlutoGridOnChangedEvent event) {},
                      configuration: const PlutoGridConfiguration(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder() {
    return getIt.get<HomeViewModel>();
  }
}
